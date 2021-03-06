{ config, pkgs, libs, ... }:
{
  home.stateVersion = "20.09";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    lxappearance
    xclip
    gnome.gnome-screenshot
    scrot
    networkmanagerapplet
    pavucontrol
    pulseaudio
    playerctl
    brightnessctl
    lsd
    bc
    ripgrep
    nitrogen
    pass-otp
  ];
  
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
