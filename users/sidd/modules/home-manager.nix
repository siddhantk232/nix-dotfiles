{ pkgs, ... }:
{
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
    (pass.withExtensions (exts: [ exts.pass-otp  ]))
  ];
  
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
