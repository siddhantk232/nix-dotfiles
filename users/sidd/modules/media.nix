{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    vlc
    gimp
    cmus

    youtube-dl
    aria # downloader
  ];
}
