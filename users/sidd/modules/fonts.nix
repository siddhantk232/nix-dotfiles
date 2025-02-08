{ pkgs, config, home, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.fira-code
  ];
}
