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
  ];
  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
