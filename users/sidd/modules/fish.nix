{ pkgs, config, ... }:
{
  # fish is enabled from nixos/configuration.nix
  xdg.configFile."fish/config.fish".text = builtins.readFile ../config/fish/config.fish;
}
