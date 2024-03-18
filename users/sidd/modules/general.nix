{ pkgs, ... }:
let
  # https://nixos.wiki/wiki/TexLive
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of
      etoolbox;
  });
in
{
  home.packages = with pkgs; [
    brave
    google-chrome

    bat
    zathura
    fzf
    jq
    htop
    btop # better htop
    tree
    feh
    rclone
    p7zip
    tldr
    awscli2
    arandr
    cloc

    tex

    vscode # society forces me to use it sometimes :(
    # (pkgs.callPackage ../packages/cisco.nix { })
    jetbrains.clion

    zoom-us
    spotify
  ];

  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
