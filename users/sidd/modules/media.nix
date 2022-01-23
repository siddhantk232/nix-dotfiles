{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    vlc
    gimp
    cmus
    newsboat

    yt-dlp
    aria # downloader

    obs-studio
  ];
}
