{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile."nvim/init.vim".text = builtins.readFile ../config/nvim/init.vim;
}
