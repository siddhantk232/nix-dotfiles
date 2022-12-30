{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    luaformatter
    pgformatter
    haskellPackages.cabal-fmt
    haskellPackages.stylish-haskell
    nodePackages.prettier
    nixpkgs-fmt

    # Language servers/tools
    ghcid
    clang-tools
    nodePackages.typescript-language-server
    gopls
    haskell-language-server
    solargraph
    nodePackages.pyright
    terraform-lsp
    nodePackages.bash-language-server
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    texlab
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
  };

  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;

  xdg.configFile."nvim/lua/siddhant/init.lua".source = ../config/nvim/lua/siddhant/init.lua;
  xdg.configFile."nvim/lua/siddhant/packer.lua".source = ../config/nvim/lua/siddhant/packer.lua;
  xdg.configFile."nvim/lua/siddhant/remap.lua".source = ../config/nvim/lua/siddhant/remap.lua;
  xdg.configFile."nvim/lua/siddhant/set.lua".source = ../config/nvim/lua/siddhant/set.lua;

  xdg.configFile."nvim/after/plugin/colors.lua".source = ../config/nvim/after/plugin/colors.lua;
  xdg.configFile."nvim/after/plugin/fugitive.lua".source = ../config/nvim/after/plugin/fugitive.lua;
  xdg.configFile."nvim/after/plugin/lsp.lua".source = ../config/nvim/after/plugin/lsp.lua;
  xdg.configFile."nvim/after/plugin/lualine.lua".source = ../config/nvim/after/plugin/lualine.lua;
  xdg.configFile."nvim/after/plugin/nvim-tree.lua".source = ../config/nvim/after/plugin/nvim-tree.lua;
  xdg.configFile."nvim/after/plugin/telescope.lua".source = ../config/nvim/after/plugin/telescope.lua;
  xdg.configFile."nvim/after/plugin/todo-comments.lua".source = ../config/nvim/after/plugin/todo-comments.lua;
  xdg.configFile."nvim/after/plugin/treesitter.lua".source = ../config/nvim/after/plugin/treesitter.lua;
  xdg.configFile."nvim/after/plugin/zenmode.lua".source = ../config/nvim/after/plugin/zenmode.lua;
}
