{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    discord
    tdesktop
    # slack
  ];
}
