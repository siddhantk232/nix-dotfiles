{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    tmux
  ];

  xdg.configFile."nvim/init.vim".text = builtins.readFile ../config/nvim/init.vim;
  xdg.configFile."nvim/plugin/sets.vim".text = builtins.readFile ../config/nvim/plugin/sets.vim;
  xdg.configFile."nvim/plugin/colors.vim".text = builtins.readFile ../config/nvim/plugin/colors.vim;

  # Fish config
  xdg.configFile."fish/config.fish".text = builtins.readFile ../config/fish/config.fish;
}
