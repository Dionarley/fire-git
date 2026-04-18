#!/usr/bin/env bash

run_tui_menu() {
  local version="${VERSION:-1.2.0}"
  local current_name current_email
  current_name=$(git config --global user.name 2>/dev/null || echo "")
  current_email=$(git config --global user.email 2>/dev/null || echo "")

  while true; do
    clear
    print_banner "$version"
    echo ""
    print_info "Current configuration:"
    [ -n "$current_name" ] && echo "  Name:  $current_name"
    [ -n "$current_email" ] && echo "  Email: $current_email"
    echo ""
    echo "========================================"
    echo "         Main Menu"
    echo "========================================"
    echo ""
    echo "  1) Reconfigure Git (name/email)"
    echo "  2) View current config"
    echo "  3) Reset configuration"
    echo "  4) Git Quick Tutorial"
    echo "  5) Apply additional settings"
    echo "  6) Show System Info"
    echo "  7) Exit"
    echo ""
    echo "========================================"
    read -p "Select option [1-7]: " choice

    case "$choice" in
      1) reconfigure_git ;;
      2) view_config "$current_name" "$current_email" ;;
      3) reset_and_restart ;;
      4) show_tutorial ;;
      5) apply_settings ;;
      6) show_system_info ;;
      7|q|Q) clear; print_success "Goodbye!"; exit 0 ;;
      *) print_warning "Invalid option. Press Enter to continue."; read ;;
    esac

    current_name=$(git config --global user.name 2>/dev/null || echo "")
    current_email=$(git config --global user.email 2>/dev/null || echo "")
  done
}

reconfigure_git() {
  clear
  print_info "Reconfiguring Git..."
  echo ""

  read -p "Enter your Git user name: " GIT_NAME
  if [ -z "$GIT_NAME" ]; then
    GIT_NAME=$(git config --global user.name 2>/dev/null || echo "")
  fi

  read -p "Enter your Git email: " GIT_EMAIL
  if [ -z "$GIT_EMAIL" ]; then
    GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")
  fi

  while ! validate_email "$GIT_EMAIL"; do
    print_warning "Invalid email format. Please try again."
    read -p "Enter your Git email: " GIT_EMAIL
  done

  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"

  print_success "Git reconfigured!"
  print_info "Press Enter to continue..."; read
}

view_config() {
  local name="$1"
  local email="$2"
  clear
  print_info "Current Git Configuration:"
  echo "========================================"
  echo "  Name:     $name"
  echo "  Email:    $email"
  echo ""
  echo "All settings:"
  git config --global --list | head -20
  echo ""
  echo "========================================"
  print_info "Press Enter to continue..."; read
}

reset_and_restart() {
  clear
  read -p "Are you sure you want to reset? [y/N]: " confirm
  if [[ "$confirm" == "y" ]] || [[ "$confirm" == "Y" ]]; then
    print_info "Resetting configuration..."
    git config --global --unset user.name 2>/dev/null || true
    git config --global --unset user.email 2>/dev/null || true
    print_success "Configuration reset!"
  fi
  print_info "Press Enter to continue..."; read
}

show_tutorial() {
  clear
  print_git_tutorial
  echo ""
  print_info "Press Enter to continue..."; read
}

apply_settings() {
  clear
  print_info "Applying additional Git settings..."
  configure_additional_settings
  print_info "Press Enter to continue..."; read
}

show_system_info() {
  clear
  print_info "System Information:"
  echo "========================================"
  local os_info env_type
  os_info=$(detect_os)
  env_type=$(detect_environment)
  echo "  OS:         $os_info"
  echo "  Environment: $env_type"
  echo "  Git:        $(git --version 2>/dev/null || echo 'not found')"
  echo ""
  echo "Package managers available:"
  for pm in apt apt-get dnf yum pacman zypper microdnf eopkg apk swupd; do
    if command -v "$pm" >/dev/null 2>&1; then
      echo "  - $pm"
    fi
  done
  echo "========================================"
  print_info "Press Enter to continue..."; read
}