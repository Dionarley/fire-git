{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerectory {
  pname = "fire-git";
  version = "1.2.0";
  src = pkgs.fetchFromGitHub {
    owner = "Donarley";
    repo = "fire-git";
    rev = "v1.2.0";
    sha256 = "0000000000000000000000000000000000000000000000000000000000000";
  };

  installPhase = ''
    runHook preInstall
    install -Dm755 src/firegit.sh $out/bin/fire-git
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Git configuration tool for Linux";
    homepage = "https://github.com/Donarley/fire-git";
    license = licenses.mit;
    maintainers = [ "Donarley" ];
  };
}