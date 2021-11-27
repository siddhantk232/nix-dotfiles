{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    vlc
    gimp
  ];
}
