# AGENTS.md - fire-git

This document provides guidance for agentic coding agents working on this repository.

## Project Overview

fire-git is a bash TUI tool that automates Git configuration (user.name and user.email).
Features include: TUI menu, multi-distro package manager detection, OS/environment detection,
email validation, git tutorial, and Flatpak sandbox support.

### Version
1.2.0

## Project Structure

```
fire-git/
├── src/
│   ├── firegit.sh           # Main entry point
│   └── lib/
│       ├── detect.sh        # OS, environment, package manager detection
│       ├── output.sh       # Banner, help, print functions
│       ├── validate.sh     # Config check/reset, email validation
│       └── tui.sh          # TUI menu system
├── flatpak/
│   └── com.github.donarley.fire-git.yaml  # Flatpak manifest
├── packages/               # Package specs for distros
├── DOCS/
│   └── *.md                 # Documentation
├── tests/
│   └── run_tests.sh        # Test suite (19 tests)
├── Dockerfile             # Docker dev environment
├── docker-compose.yml     # Docker compose
├── installer.sh          # Cross-installer
├── README.md
├── LICENSE
└── AGENTS.md
```

### Docker Development

```bash
# Build dev image
docker build -t fire-git-dev .

# Run tests in container
docker run --rm fire-git-dev ./tests/run_tests.sh

# Run with compose
docker-compose run test

# Interactive shell
docker-compose run dev
```

## Build/Test Commands

### Running the Script

```bash
# Make executable
chmod +x src/firegit.sh

# Run (TUI mode if git already configured)
./src/firegit.sh

# Run with environment variables
GIT_NAME="Your Name" GIT_EMAIL="you@example.com" ./src/firegit.sh

# Run via Flatpak
flatpak run com.github.donarley.fire-git
```

### CLI Options

```bash
./src/firegit.sh -h, --help       # Show help
./src/firegit.sh --check          # Check current config
./src/firegit.sh --reset          # Reset configuration
./src/firegit.sh --tutorial       # Show git tutorial
```

### Validation Commands

```bash
# Syntax check all scripts
bash -n src/firegit.sh
bash -n src/lib/*.sh

# ShellCheck (if available)
shellcheck src/firegit.sh
shellcheck src/lib/*.sh

# Run complete test suite
./tests/run_tests.sh

# Run single test (from test function name)
bash -c 'source tests/run_tests.sh; test_syntax'
```

### Environment Variables

- `GIT_NAME` - Git user name (optional)
- `GIT_EMAIL` - Git user email (optional)
- `APPLY_ADDITIONAL` - Apply extra settings (default: true)

## Code Style Guidelines

### General Principles

- Use `set -e` to exit on errors
- Use `#!/usr/bin/env bash` shebang (portable)
- Keep scripts POSIX-compatible where possible

### Source Order

```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"

source "$LIB_DIR/output.sh"
source "$LIB_DIR/detect.sh"
source "$LIB_DIR/validate.sh"
source "$LIB_DIR/tui.sh"
```

### Formatting

- Use 2-space indentation
- No trailing whitespace
- Use quotes around variables: `"$VAR"` not `$VAR`
- Prefer double quotes unless literal strings needed
- Max 80 chars per line where practical

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Variables | `UPPER_SNAKE_CASE` | `GIT_NAME`, `PKG_MANAGER` |
| Constants | `UPPER_SNAKE_CASE` | `VERSION`, `ASCII_ART` |
| Functions | `snake_case` | `detect_package_manager` |
| Scripts | `lowercase` | `firegit.sh` |

### Library Functions

Export shared variables when needed:
```bash
export VERSION="1.2.0"
```

Source libraries in proper order.

### Error Handling

```bash
# Exit on any error
set -e

# Check command exists
if command -v git >/dev/null 2>&1; then
    echo "Git found"
fi

# Exit with message
echo "Error message" >&2
exit 1
```

### Input/Output

- Use `echo -e` for escape sequences
- Use `read -p "prompt" var` for user input
- Use `clear` in TUI for screen refresh

### Output Functions

```bash
print_info()   # ℹ info message
print_success() # ✅ success message
print_warning() # ⚠️ warning message
print_error()   # ❌ error (to stderr)
```

### Conditionals

```bash
# Command exists
if command -v git >/dev/null 2>&1; then

# Variable empty
if [ -z "$VAR" ]; then

# File exists
if [ -f "$FILE" ]; then
```

### TUI Functions

Return values for menu loops:
```bash
# Return 1 = continue loop
# Return 0/exit = exit program
```

## Flatpak Requirements

- Runtime: `org.freedesktop.Platform` v23.08
- Required finish-args:
  - `--share=network`
  - `--filesystem=home`
  - `--device=all`
  - `--talk-name=org.freedesktop.Flatpak`

## Tests

Current tests (must pass 19/19):

```bash
test_syntax              # bash -n check
test_shebang           # Portable shebang
test_set_e             # Error handling
test_variable_quoting  # Quoted variables
test_package_managers  # 10+ package managers
test_help_flag         # -h/--help
test_check_flag       # --check
test_reset_flag       # --reset
test_email_validation # Email regex
test_os_detection     # /etc/os-release
test_environment_detection # Flatpak/etc
test_tutorial_flag   # --tutorial
test_additional_settings # Extra git settings
test_existing_config_check # Skip if configured
test_tui_menu        # TUI menu present
test_clear_screen    # clear command
test_flatpak_manifest # Valid manifest
test_no_hardcoded_secrets # No credentials
test_readme_exists   # README file
```

## Commit Messages

Use imperative mood:

- "Add TUI menu system"
- "Add 10+ package manager detection"
- "Fix existing config check logic"
- "Update runtime to 23.08"
- "Refactor into lib modules"

## Security Considerations

- Never hardcode credentials or tokens
- Validate email with regex before saving
- Validate all user input
- Use `--filesystem=home` minimally (Flatpak)
- Prefer system git over bundled