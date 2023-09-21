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

    vscode
    (pkgs.callPackage ../packages/cisco.nix { })
  ];
  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
