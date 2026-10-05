{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go

    nodejs

    # haskellPackages.ghc
    # cabal-install

    stdenv.cc
    # gdb
    # gf # gdb-frontend
    python311

    rustc
    cargo
    cargo-watch
    rustfmt
    clippy
  ];
}
