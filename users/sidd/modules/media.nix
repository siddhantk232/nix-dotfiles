{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    vlc
    gimp
    cmus

    yt-dlp
    aria # downloader
    (pkgs.callPackage ../packages/heroic-games-launcher.nix { })
    lutris
    wineWowPackages.base

    obs-studio
  ];
}
