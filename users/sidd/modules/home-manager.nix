{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    lxappearance
    xclip
    gnome-screenshot
    scrot
    networkmanagerapplet
    pavucontrol
    pulseaudio
    playerctl
    brightnessctl
    bc
    nitrogen # wallpaper on linux
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    zathura
    feh
    arandr
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
