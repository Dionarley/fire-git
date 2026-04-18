name=fire-git
version=1.2.0
release=1
summary="Git configuration tool for Linux"
description="A bash TUI tool that automates Git configuration"
license=MIT
url=https://github.com/Donarley/fire-git
packager=Donarley <donarley@proton.me>
requires=git
changelog=changelog

%install
install -D firegit.sh %{buildroot}%{_bindir}/fire-git

%files
%{_bindir}/fire-git