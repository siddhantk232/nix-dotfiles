{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # blender
    vlc
    gimp
    cmus

    yt-dlp
    aria # downloader

    # obs-studio
  ];
}
