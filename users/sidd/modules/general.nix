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
  ];
  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
