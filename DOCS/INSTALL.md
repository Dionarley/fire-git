# Installation Guide

## Flatpak (Recommended)

The safest and most portable option. Download the `.flatpak` file from the Releases page.

```bash
# Install the bundle
flatpak install --user fire-git.flatpak

# Run
flatpak run com.github.dionarley.fire-git
```

## Direct Script (Bash)

Run the script directly in your terminal:

```bash
chmod +x firegit.sh
./firegit.sh
```

## Environment Variables

- `GIT_NAME` - Your Git user name (optional, prompts if not set)
- `GIT_EMAIL` - Your Git email (optional, prompts if not set)

Example non-interactive run:

```bash
GIT_NAME="Your Name" GIT_EMAIL="you@example.com" ./firegit.sh
```