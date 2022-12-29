{ config, pkgs, ... }:
{
  # Fish config
  xdg.configFile."fish/config.fish".text = builtins.readFile ../config/fish/config.fish;
  xdg.configFile."fish/fish_plugins".text = builtins.readFile ../config/fish/fish_plugins;
  xdg.configFile."fish/fish_variables".text = builtins.readFile ../config/fish/fish_variables;

  xdg.configFile."fish/completions/fisher.fish".text = builtins.readFile ../config/fish/completions/fisher.fish;
  xdg.configFile."fish/completions/sdk.fish".text = builtins.readFile ../config/fish/completions/sdk.fish;
  xdg.configFile."fish/conf.d/sdk.fish".text = builtins.readFile ../config/fish/conf.d/sdk.fish;

  xdg.configFile."fish/functions/fisher.fish".text = builtins.readFile ../config/fish/functions/fisher.fish;
  xdg.configFile."fish/functions/fish_ssh_agent.fish".text = builtins.readFile ../config/fish/functions/fish_ssh_agent.fish;
  xdg.configFile."fish/functions/sdk.fish".text = builtins.readFile ../config/fish/functions/sdk.fish;
}
