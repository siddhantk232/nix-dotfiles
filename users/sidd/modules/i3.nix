{ pkgs, ... }:
{
  xdg.configFile."hypr/hyprland.conf".text = builtins.readFile ../config/i3/hyprland.conf;
  xdg.configFile."ghostty/config".text = builtins.readFile ../config/ghostty;
  xdg.configFile."i3/i3status-rs.toml".text = builtins.readFile ../config/i3/i3status-rs.toml;

  home.packages = with pkgs; [
    ghostty

    (pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; })
  ];
}
