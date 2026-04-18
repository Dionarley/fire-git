#!/usr/bin/env bash
set -e

VERSION="1.2.0"

install_firegit() {
  local install_dir="${1:-$HOME/.local/bin}"
  local repo_url="https://raw.githubusercontent.com/Dionarley/fire-git/main"

  echo "Installing fire-git v$VERSION..."

  mkdir -p "$install_dir"

  curl -sL "$repo_url/src/firegit.sh" -o "$install_dir/fire-git"
  chmod +x "$install_dir/fire-git"

  echo "Installed to $install_dir/fire-git"
  echo "Run: $install_dir/fire-git"
}

configure_git_direct() {
  local git_name="$1"
  local git_email="$2"

  if [ -z "$git_name" ] || [ -z "$git_email" ]; then
    echo "Usage: curl -sL https://git.io/fire-git | bash -s -- 'Your Name' 'you@example.com'"
    echo "Or: wget -qO- https://git.io/fire-git | bash -s -- 'Your Name' 'you@example.com'"
    exit 1
  fi

  echo "Configuring Git..."

  if command -v git >/dev/null 2>&1; then
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    git config --global fetch.prune true
    git config --global color.ui auto
    echo "Git configured:"
    echo "  Name:  $(git config --global user.name)"
    echo "  Email: $(git config --global user.email)"
  else
    echo "Git not found. Install git first:"
    echo "  Debian/Ubuntu: sudo apt install git"
    echo "  Fedora:        sudo dnf install git"
    echo "  Arch:         sudo pacman -S git"
    echo "  Alpine:      sudo apk add git"
    exit 1
  fi
}

main() {
  if [ -n "$1" ] && [ -n "$2" ]; then
    configure_git_direct "$1" "$2"
  elif [ "$1" = "install" ]; then
    install_firegit "$2"
  else
    echo "fire-git installer v$VERSION"
    echo ""
    echo "Usage:"
    echo "  Configure git directly:"
    echo "    curl -sL https://git.io/fire-git | bash -s -- 'Your Name' 'you@example.com'"
    echo "    wget -qO- https://git.io/fire-git | bash -s -- 'Your Name' 'you@example.com'"
    echo ""
    echo "  Install fire-git TUI:"
    echo "    curl -sL https://git.io/fire-git | bash -s -- install"
    echo "    wget -qO- https://git.io/fire-git | bash -s -- install"
    echo ""
    echo "Examples:"
    echo "  curl -sL https://git.io/fire-git | bash -s -- 'John Doe' 'john@example.com'"
    echo "  curl -sL https://git.io/fire-git | bash -s -- install ~/.local/bin"
  fi
}

main "$@"