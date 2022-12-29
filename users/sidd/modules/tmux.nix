{ config, pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];
  home.file.".tmux.conf".text = builtins.readFile ../config/tmux.conf;
}
