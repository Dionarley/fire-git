# fire-git

The fastest and easiest way to configure Git on any Linux distribution.

fire-git is a bash TUI tool that automates Git configuration (`user.name` and `user.email`).
Features include: interactive TUI menu, multi-distro package manager detection,
OS/environment detection, email validation, git tutorial, and Flatpak sandbox support.

## Features

- **Automatic Configuration** - Sets name and email globally with a single command
- **Interactive TUI Menu** - User-friendly menu interface with multiple options
- **10+ Package Managers** - Supports apt, apt-get, dnf, yum, pacman, zypper, microdnf, eopkg, apk, swupd
- **System Detection** - Detects OS, environment (Flatpak, Snap, Docker, Nix), package managers
- **Email Validation** - Validates email format before saving
- **Git Tutorial** - Built-in quick reference guide
- **Additional Settings** - Applies useful git settings (defaultBranch, pull.rebase, etc.)
- **Flatpak Support** - Works in sandbox environments (SteamOS, Fedora Silverblue)
- **MIT Licensed** - Free and open source

## Quick Start

### One-Line Install (No Download)

```bash
# Configure git directly
curl -sL https://github.com/Donarley/fire-git/raw/main/installer.sh | bash -s -- 'Your Name' 'you@example.com'
```

### Local Run

```bash
# Make executable and run
chmod +x src/firegit.sh
./src/firegit.sh
```

Or with environment variables:

```bash
GIT_NAME="Your Name" GIT_EMAIL="you@example.com" ./src/firegit.sh
```

## CLI Options

```bash
-h, --help       Show help message
--check          Check current git configuration
--reset         Reset git configuration
--tutorial       Show git quick tutorial
```

## TUI Menu

When git is already configured, fire-git opens an interactive menu:

1. Reconfigure Git (name/email)
2. View current config
3. Reset configuration
4. Git Quick Tutorial
5. Apply additional settings
6. Show System Info
7. Exit

## Package Managers Supported

| Manager | Distributions |
|---------|---------------|
| apt/apt-get | Debian, Ubuntu, Linux Mint |
| dnf | Fedora, RHEL 8+ |
| yum | RHEL 7, CentOS |
| pacman | Arch Linux, Manjaro |
| zypper | openSUSE |
| microdnf | Fedora Silverblue, CentOS Stream |
| eopkg | Solus |
| apk | Alpine Linux |
| swupd | Clear Linux |

## Environment Variables

- `GIT_NAME` - Git user name (optional, prompts if not set)
- `GIT_EMAIL` - Git user email (optional, prompts if not set)
- `APPLY_ADDITIONAL` - Apply extra settings (default: true)

## Documentation

See [DOCS/](DOCS/) for full documentation:

- [DOCS/INSTALL.md](DOCS/INSTALL.md) - Installation options
- [DOCS/FLATPAK.md](DOCS/FLATPAK.md) - Flatpak guide
- [DOCS/CONTRIBUTING.md](DOCS/CONTRIBUTING.md) - Contributing guide

## License

MIT - See [LICENSE](LICENSE) for details.