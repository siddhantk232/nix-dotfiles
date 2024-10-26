{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go

    nodejs

    # haskellPackages.ghc
    # cabal-install

    gcc
    # gdb
    # gf # gdb-frontend
    python311

    rustc
    cargo
    rustfmt
    clippy
  ];
}
