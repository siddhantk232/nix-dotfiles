{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # vlc

    yt-dlp
    aria # downloader

    # obs-studio
  ];
}
