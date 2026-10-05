{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    clang-tools
    lldb

    tree-sitter # not required by nvim

    # lsp servers
    lua-language-server
    bash-language-server
    pyright
    rust-analyzer

    gopls

    typescript # required by tsserver
    # nodePackages.typescript-language-server
    prettier
  ];

  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;
}
