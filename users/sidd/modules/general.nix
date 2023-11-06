{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome
    bat
    zathura
    fzf
    jq
    htop
    tree
    feh
    rclone
    p7zip
    tldr
    awscli2
    arandr

    texlive.combined.scheme-small

    cloc

    vscode
    (pkgs.callPackage ../packages/cisco.nix { })

    zoom-us
  ];
  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
