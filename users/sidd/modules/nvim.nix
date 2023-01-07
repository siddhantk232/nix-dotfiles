{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
  };

  home.packages = [ pkgs.clang-tools ];

  xdg.configFile."nvim".source = ../config/nvim;
}
