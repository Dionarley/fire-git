# Installation Guide

This guide covers all supported installation methods for fire-git.

## Quick Install (One-Line)

The fastest way to configure Git on any Linux system with internet access:

```bash
curl -sL https://github.com/Donarley/fire-git/raw/main/installer.sh | bash -s -- 'Your Name' 'you@example.com'
```

## Distribution-Specific Install

### Debian / Ubuntu / Linux Mint

```bash
# Install git if needed
sudo apt update
sudo apt install git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

Or via script:
```bash
curl -sL https://github.com/Donarley/fire-git/raw/main/installer.sh | bash -s -- install ~/.local/bin
~/.local/bin/fire-git
```

### Fedora / RHEL / CentOS Stream

```bash
# Install git if needed
sudo dnf install git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

### Arch Linux / Manjaro / EndeavourOS

```bash
# Install git if needed
sudo pacman -S git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

Or use AUR (when available):
```bash
yay -S fire-git
```

### openSUSE

```bash
# Install git if needed
sudo zypper install git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

### Alpine Linux

```bash
# Install git if needed
apk add git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

### Solus

```bash
# Install git if needed
eopkg install git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

### Clear Linux

```bash
# Install git if needed
sudo swupd bundle-add git

# Clone and use
git clone https://github.com/Donarley/fire-git.git
cd fire-git
chmod +x src/firegit.sh
./src/firegit.sh
```

## Environment Variables

Pass configuration via environment:

```bash
# Set git name and email
export GIT_NAME="Your Name"
export GIT_EMAIL="you@example.com"

# Optionally disable additional settings
export APPLY_ADDITIONAL=false

# Run
./src/firegit.sh
```

## Non-Interactive Mode

Use existing environment variables:

```bash
GIT_NAME="Your Name" GIT_EMAIL="you@example.com" ./src/firegit.sh
```