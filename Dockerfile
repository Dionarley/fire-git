# Development Docker Environment

This directory contains Docker-based development environment for fire-git.

## Quick Start

```bash
# Build the development image
docker build -t fire-git-dev .

# Run tests in container
docker run --rm fire-git-dev ./tests/run_tests.sh

# Run the tool
docker run --rm -it -e GIT_NAME="Dev User" -e GIT_EMAIL="dev@example.com" fire-git-dev
```

## Using Docker Compose

```bash
# Run tests
docker-compose run test

# Run interactive shell
docker-compose run dev
```

## Pre-built Image

```bash
docker pull ghcr.io/donarley/fire-git:dev
```

## Notes

- Git config is stored in `/root/.gitconfig`
- Source is mounted at `/app`
- Entry point runs the tool directly