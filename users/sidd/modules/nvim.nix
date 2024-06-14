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

    # lsp servers
    lua-language-server
    nodePackages.bash-language-server
    nodePackages.pyright
    rust-analyzer

    gopls

    nodePackages.typescript # required by tsserver
    nodePackages.typescript-language-server
    nodePackages.prettier
  ];

  xdg.configFile."nvim".source = ../config/nvim;
}
