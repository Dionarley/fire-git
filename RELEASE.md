# Release Plan

## Version History

| Version | Date | Status | Notes |
|---------|------|--------|-------|
| 1.0.0 | 2024-01 | Released | Initial release |
| 1.2.0 | 2024-06 | Released | TUI menu, 10+ package managers |
| 1.3.0 | Planned | - | See below |

## Planned Release v1.3.0

### Features

- [x] TUI menu with 7 options
- [x] 10+ package manager detection
- [x] OS/environment detection  
- [x] Email validation
- [x] Git tutorial
- [x] Additional settings
- [x] One-line installer
- [x] Package specs (AUR, RPM, Nix, Snap)
- [x] Docker dev environment

### Milestones

- [x] Code: Core features implemented
- [x] Tests: 19/19 passing
- [x] Docs: README, INSTALL, FLATPAK guides
- [x] Pkg: Package specs for distros
- [x] Docker: Dev environment

### Release Checklist

- [ ] Version bump in code
- [ ] Changelog update
- [ ] Create git tag
- [ ] Build package artifacts
- [ ] Create GitHub release
- [ ] Push to remote
- [ ] Publish to AUR (PKGBUILD)
- [ ] Announce

### Package Artifacts

Produce for release:
- `fire-git-1.3.0.tar.gz` - Source tarball
- `fire-git.flatpak` - Flatpak bundle
- `fire-git-1.3.0-x86_64.pkg.tar.zst` - Arch package

### Channels

- GitHub Releases
- AUR (Arch)
- Nix channels

## Release Commands

```bash
# Version bump
sed -i 's/VERSION="1.2.0"/VERSION="1.3.0"/' src/firegit.sh

# Tag
git tag -a v1.3.0 -m "Release v1.3.0"

# Push
git push origin main --tags
```

## Rollback Plan

If issues found:
1. Revert tag: `git tag -d v1.3.0 && git push origin :refs/tags/v1.3.0`
2. Hotfix branch: `git checkout -b fix/v1.3.1`
3. Release v1.3.1