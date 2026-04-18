#!/usr/bin/env bash

check_current_config() {
  echo "Checking current Git configuration..."
  local current_name current_email
  current_name=$(git config --global user.name 2>/dev/null || echo "")
  current_email=$(git config --global user.email 2>/dev/null || echo "")

  if [ -n "$current_name" ] || [ -n "$current_email" ]; then
    echo "Current configuration:"
    [ -n "$current_name" ] && echo "  Name:  $current_name"
    [ -n "$current_email" ] && echo "  Email: $current_email"
  else
    echo "No configuration found."
  fi
}

reset_config() {
  echo "Resetting Git configuration..."
  git config --global --unset user.name 2>/dev/null || true
  git config --global --unset user.email 2>/dev/null || true
  echo "Configuration removed."
}

validate_email() {
  local email="$1"
  if echo "$email" | grep -qE '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; then
    return 0
  fi
  return 1
}

check_existing_config() {
  local current_name current_email
  current_name=$(git config --global user.name 2>/dev/null || echo "")
  current_email=$(git config --global user.email 2>/dev/null || echo "")

  if [ -n "$current_name" ] && [ -n "$current_email" ]; then
    echo "Git is already configured!"
    echo "  Name:  $current_name"
    echo "  Email: $current_email"
    return 1
  fi
  return 0
}

prompt_for_input() {
  if [ -z "$GIT_NAME" ]; then
    read -p "Enter your Git user name: " GIT_NAME
  fi

  if [ -z "$GIT_EMAIL" ]; then
    read -p "Enter your Git email: " GIT_EMAIL
  fi

  while ! validate_email "$GIT_EMAIL"; do
    echo "Invalid email format. Please try again."
    read -p "Enter your Git email: " GIT_EMAIL
  done
}

configure_additional_settings() {
  print_info "Applying additional Git settings..."

  git config --global init.defaultBranch main 2>/dev/null || true
  git config --global pull.rebase false 2>/dev/null || true
  git config --global push.default current 2>/dev/null || true
  git config --global fetch.prune true 2>/dev/null || true
  git config --global color.ui auto 2>/dev/null || true

  print_success "Additional settings applied!"
}

print_git_tutorial() {
  echo ""
  echo "========================================"
  echo "       Git Quick Tutorial"
  echo "========================================"
  echo ""
  echo "Basic Commands:"
  echo "  git init              - Initialize new repository"
  echo "  git clone <url>     - Clone existing repository"
  echo "  git status          - Check current state"
  echo "  git add <file>      - Stage changes"
  echo "  git commit -m 'msg'  - Commit with message"
  echo "  git push            - Upload to remote"
  echo "  git pull            - Download from remote"
  echo "  git log            - View commit history"
  echo ""
  echo "Common Aliases (optional):"
  echo "  git config --global alias.st status"
  echo "  git config --global alias.co checkout"
  echo "  git config --global alias.br branch"
  echo "  git config --global alias.ci commit"
  echo "  git config --global alias.unstage 'reset HEAD --'"
  echo ""
  echo "Useful Settings:"
  echo "  init.defaultBranch  - Default branch name (main)"
  echo "  pull.rebase       - Rebase on pull (false)"
  echo "  push.default     - Push strategy (current)"
  echo "  fetch.prune      - Auto-prune refs (true)"
  echo "  color.ui        - Color output (auto)"
  echo ""
  echo "Get help: git help <command>"
  echo "========================================"
}