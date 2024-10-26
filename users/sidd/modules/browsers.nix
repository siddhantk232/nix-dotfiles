{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # brave
    google-chrome
    # firefox
  ];
}
