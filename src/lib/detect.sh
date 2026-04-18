#!/usr/bin/env bash

detect_os() {
  local os_name=""
  local os_version=""

  if [ -f /etc/os-release ]; then
    . /etc/os-release
    os_name="$NAME"
    os_version="$VERSION_ID"
  elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    os_name="$DISTRIB_ID"
    os_version="$DISTRIB_RELEASE"
  elif [ -f /etc/alpine-release ]; then
    os_name="Alpine"
    os_version=$(cat /etc/alpine-release)
  elif [ -f /etc/arch-release ]; then
    os_name="Arch Linux"
    os_version="rolling"
  fi

  echo "$os_name $os_version"
}

detect_environment() {
  local env_type=""

  if [ -n "$FLATPAK_ID" ]; then
    env_type="flatpak"
  elif [ -n "$SNAP_ARCH" ]; then
    env_type="snap"
  elif [ -n "$NIX_ENVIRONMENT" ] || [ -n "$NIX_PROFILE" ]; then
    env_type="nix"
  elif [ -f /.dockerenv ]; then
    env_type="docker"
  elif [ -f /run/.containerenv ]; then
    env_type="container"
  elif command -v flatpak >/dev/null 2>&1 && [ -z "$1" ]; then
    env_type="flatpak-sandbox"
  fi

  echo "$env_type"
}

detect_package_manager() {
  local pkg_manager=""
  local install_cmd=""

  if command -v apt >/dev/null 2>&1; then
    pkg_manager="apt"
    install_cmd="apt install -y git"
  elif command -v apt-get >/dev/null 2>&1; then
    pkg_manager="apt-get"
    install_cmd="apt-get install -y git"
  elif command -v dnf >/dev/null 2>&1; then
    pkg_manager="dnf"
    install_cmd="dnf install -y git"
  elif command -v yum >/dev/null 2>&1; then
    pkg_manager="yum"
    install_cmd="yum install -y git"
  elif command -v pacman >/dev/null 2>&1; then
    pkg_manager="pacman"
    install_cmd="pacman -S --noconfirm git"
  elif command -v zypper >/dev/null 2>&1; then
    pkg_manager="zypper"
    install_cmd="zypper install -y git"
  elif command -v microdnf >/dev/null 2>&1; then
    pkg_manager="microdnf"
    install_cmd="microdnf install -y git"
  elif command -v eopkg >/dev/null 2>&1; then
    pkg_manager="eopkg"
    install_cmd="eopkg install -y git"
  elif command -v apk >/dev/null 2>&1; then
    pkg_manager="apk"
    install_cmd="apk add git"
  elif command -v swupd >/dev/null 2>&1; then
    pkg_manager="swupd"
    install_cmd="swupd bundle-install git"
  fi

  if [ -n "$pkg_manager" ]; then
    echo "$pkg_manager:$install_cmd"
  else
    echo ""
  fi
}

install_git() {
  local pkg_info="$1"
  local pkg_manager="${pkg_info%%:*}"
  local install_cmd="${pkg_info#*:}"

  echo "Installing Git via $pkg_manager..."
  echo "Command: $install_cmd"

  if eval "$install_cmd"; then
    echo "Git installed successfully."
    return 0
  else
    echo "Failed to install Git. Please install Git manually."
    return 1
  fi
}