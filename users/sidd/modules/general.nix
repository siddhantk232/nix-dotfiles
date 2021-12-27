{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
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
