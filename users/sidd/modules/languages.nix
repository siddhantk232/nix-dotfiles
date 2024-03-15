{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go

    nodejs

    haskellPackages.ghc
    cabal-install

    gcc
    python311

    rustc
    cargo
    rustfmt
  ];
}
