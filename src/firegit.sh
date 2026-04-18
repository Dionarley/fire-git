#!/usr/bin/env bash
set -e

export VERSION="1.2.0"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"

source "$LIB_DIR/output.sh"
source "$LIB_DIR/detect.sh"
source "$LIB_DIR/validate.sh"
source "$LIB_DIR/tui.sh"

main() {
  if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    print_help "$VERSION"
    exit 0
  fi

  if [[ "$1" == "--check" ]]; then
    check_current_config
    exit 0
  fi

  if [[ "$1" == "--reset" ]]; then
    reset_config
    exit 0
  fi

  if [[ "$1" == "--tutorial" ]]; then
    print_git_tutorial
    exit 0
  fi

  print_banner "$VERSION"
  print_info "Initializing Git configurator..."

  local os_info
  os_info=$(detect_os)
  local env_type
  env_type=$(detect_environment)

  [ -n "$os_info" ] && print_info "Detected OS: $os_info"
  [ -n "$env_type" ] && print_info "Environment: $env_type"

  if command -v git >/dev/null 2>&1; then
    print_success "Git found: $(git --version)"

    if ! check_existing_config; then
      run_tui_menu
    else
      print_git_tutorial
    fi
  else
    print_warning "Git not found. Trying to detect package manager..."

    local pkg_info
    pkg_info=$(detect_package_manager)

    if [ -n "$pkg_info" ]; then
      install_git "$pkg_info"
      run_tui_menu
    else
      print_error "No package manager detected."
      print_error "Please install Git manually on your system."
      exit 1
    fi
  fi
}

main "$@"