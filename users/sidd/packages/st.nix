{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation rec {
  pname = "siddhantk232-st";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "siddhantk232";
    repo = "st";
    rev = "76b6e1a6501af0cfd89d9652949e93122accab2b";
    hash = "sha256-xiyJMLfmPDctW+pa4LRnddoZW71cGoBGrDorgTJB2NE=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    fontconfig
    harfbuzz
    xorg.libX11
    xorg.libXext
    xorg.libXft
    ncurses
  ];

  installPhase = ''
    runHook preInstall

    TERMINFO=$out/share/terminfo make install PREFIX=$out

    runHook postInstall
  '';
}
