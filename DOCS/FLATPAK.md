# Flatpak Guide

## Overview

fire-git runs in a Flatpak sandbox to ensure portability across distributions like SteamOS, Fedora Silverblue, and other immutable systems.

## Runtime

- **Runtime**: `org.freedesktop.Platform`
- **Version**: `23.08`
- **SDK**: `org.freedesktop.Sdk`

## Permissions (finish-args)

| Permission | Purpose |
|------------|----------|
| `--share=network` | Required for git operations |
| `--filesystem=home` | Required to modify `~/.gitconfig` |
| `--device=all` | Required for system git detection |
| `--talk-name=org.freedesktop.Flatpak` | Required for sandbox communication |

## Building

```bash
# Build the flatpak
flatpak-builder --user --force-clean build-dir com.github.dionarley.fire-git.yaml

# Create bundle
flatpak build-bundle fire-git.flatpak com.github.dionarley.fire-git
```

## Installing Bundle

```bash
flatpak install --user fire-git.flatpak
flatpak run com.github.dionarley.fire-git
```