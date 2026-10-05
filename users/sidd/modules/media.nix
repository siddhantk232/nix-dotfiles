{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # vlc

    yt-dlp
    aria2 # downloader

    # obs-studio
  ];
}
