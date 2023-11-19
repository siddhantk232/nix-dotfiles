{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    clang-tools
    lldb

    tree-sitter # not required by nvim
  ];

  xdg.configFile."nvim".source = ../config/nvim;
}
