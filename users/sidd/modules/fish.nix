{ config, pkgs, ... }:
{
  # Fish config
  xdg.configFile."fish".source = ../config/fish;
}
