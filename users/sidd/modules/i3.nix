{ pkgs, ... }:
{
  xdg.configFile."i3/config".text = builtins.readFile ../config/i3/config;
  xdg.configFile."i3status-rust/config.toml".text = builtins.readFile ../config/i3/i3status-rs.toml;
  home.packages = [ pkgs.lukesmithxyz-st ];
}
