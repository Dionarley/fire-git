# fire-git

> A cross-distribution Git configuration tool for Linux

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.2.0-blue.svg)](https://github.com/Donarley/fire-git/releases)
[![Platform](https://img.shields.io/badge/platform-Linux-black.svg)](https://github.com/Donarley/fire-git)
[![Shell](https://img.shields.io/badge/shell-bash-orange.svg)](https://www.gnu.org/software/bash/)

fire-git is a bash-based TUI (Text User Interface) tool that automates Git configuration
(`user.name` and `user.email`). It works on any Linux distribution and supports
sandbox environments like Flatpak.

## Features

| Feature | Description |
|--------|-------------|
| **TUI Menu** | Interactive 7-option menu interface |
| **Auto-Detection** | Detects 10+ package managers automatically |
| **System Detection** | Identifies OS, environment (Flatpak/Snap/Docker) |
| **Validation** | Validates email format before saving |
| **Tutorial** | Built-in Git quick reference |
| **Settings** | Applies recommended Git defaults |

## Supported Systems

### Package Managers

| Manager | Distributions |
|---------|---------------|
| apt/apt-get | Debian, Ubuntu, Linux Mint, Pop!_OS |
| dnf | Fedora, RHEL 8+, CentOS Stream |
| yum | RHEL 7, CentOS 7 |
| pacman | Arch Linux, Manjaro, EndeavourOS |
| zypper | openSUSE, SUSE Linux Enterprise |
| microdnf | Fedora Silverblue, CentOS Stream |
| eopkg | Solus |
| apk | Alpine Linux |
| swupd | Clear Linux |

### Environments

- Native (bare metal)
- Flatpak sandbox
- Snap sandbox
- Docker container
- Nix environment

## Installation

### One-Line (Quickest)

```bash
# Configure Git directly
curl -sL https://github.com/Donarley/fire-git/raw/main/installer.sh | bash -s -- 'Your Name' 'you@example.com'
```

### From Source

```bash
# Clone and run
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

### Environment Variables

```bash
GIT_NAME="Your Name" GIT_EMAIL="you@example.com" ./src/firegit.sh
```

## Package Managers (Repository)

Add your distribution's package manager below.

| Distribution | Command |
|-------------|---------|
| Arch Linux | `yay -S fire-git` (AUR) |
| NixOS | `nix-env -i fire-git` |

## CLI Options

```bash
-h, --help       Display help
--check          View current git configuration
--reset         Remove git configuration
--tutorial      Show Git quick reference
```

## TUI Menu Options

When Git is already configured, fire-git displays an interactive menu:

```
========================================
         Main Menu
========================================

  1) Reconfigure Git (name/email)
  2) View current config
  3) Reset configuration
  4) Git Quick Tutorial
  5) Apply additional settings
  6) Show System Info
  7) Exit
```

## Git Settings Applied

fire-git automatically applies these recommended settings:

| Setting | Value | Description |
|---------|-------|-------------|
| `init.defaultBranch` | main | Default branch name |
| `pull.rebase` | false | Merge strategy |
| `push.default` | current | Push strategy |
| `fetch.prune` | true | Auto-prune refs |
| `color.ui` | auto | Color output |

## Documentation

- [Installation Guide](DOCS/INSTALL.md)
- [Flatpak Guide](DOCS/FLATPAK.md)
- [Contributing](DOCS/CONTRIBUTING.md)

## License

MIT License - See [LICENSE](LICENSE) for details.

## Author

Donarley - [GitHub](https://github.com/Donarley/fire-git)