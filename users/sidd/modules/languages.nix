{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    nodejs
    haskellPackages.ghc
    gcc
    python311
    cabal-install
  ];
}
