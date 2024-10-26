{ pkgs, ... }:
let
  # https://nixos.wiki/wiki/TexLive
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      dvisvgm dvipng# for preview and export as html
      wrapfig amsmath ulem hyperref capt-of
      etoolbox;
  });
in
{
  home.packages = with pkgs; [
    tex
  ];
}
