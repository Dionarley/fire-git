#!/usr/bin/env bash

print_banner() {
  local version="$1"
  local ascii_art=" _____ _             ____ _ _   
|  ___(_)_ __ ___   / ___(_) |_ 
| |_  | | '__/ _ \ | |  _| | __|
|  _| | | | |  __/ | |_| | | |_ 
|_|   |_|_|  \___|  \____|_|\__|"

  echo -e "$ascii_art"
  echo "fire-git v$version"
}

print_help() {
  local version="$1"
  echo "fire-git v$version"
  echo ""
  echo "Usage: firegit [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  -h, --help       Show this help message"
  echo "  --check         Check current git configuration"
  echo "  --reset         Reset git configuration (remove existing)"
  echo "  --tutorial      Show git quick tutorial"
  echo ""
  echo "Environment Variables:"
  echo "  GIT_NAME           Git user name"
  echo "  GIT_EMAIL         Git user email"
  echo "  APPLY_ADDITIONAL  Apply extra settings (default: true)"
}

print_info() {
  echo "ℹ $1"
}

print_success() {
  echo "✅ $1"
}

print_warning() {
  echo "⚠️  $1"
}

print_error() {
  echo "❌ $1" >&2
}