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
  ];

  xdg.configFile."nvim".source = ../config/nvim;
}
