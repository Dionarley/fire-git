# Contributing Guide

## Development Setup

```bash
# Clone the repository
git clone https://github.com/Dionarley/fire-git.git
cd fire-git
```

## Running the Script

```bash
# Make executable and run
 chmod +x src/firegit.sh && ./src/firegit.sh

# Or with environment variables
GIT_NAME="Test User" GIT_EMAIL="test@example.com" ./src/firegit.sh
```

## Validation Commands

```bash
# Syntax check
bash -n src/firegit.sh

# ShellCheck (if available)
shellcheck src/firegit.sh

# Run test suite
./tests/run_tests.sh
```

## Code Style

- Use `#!/usr/bin/env bash` shebang
- Use `set -e` for error handling
- Use 2-space indentation
- Quote variables: `"$VAR"`
- Use `UPPER_SNAKE_CASE` for variables

## Testing Changes

1. Run syntax check: `bash -n firegit.sh`
2. Run test suite: `./tests/run_tests.sh`
3. Test manually with environment variables

## Commit Messages

Use clear, concise messages in imperative mood:

- "Add pacman support for Arch Linux"
- "Fix git detection in Flatpak sandbox"
- "Update runtime to 23.08"