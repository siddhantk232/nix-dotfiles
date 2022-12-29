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

  xdg.configFile."nvim/plugin/colors.vim".text = builtins.readFile ../config/nvim/plugin/colors.vim;
  xdg.configFile."nvim/plugin/sets.vim".text = builtins.readFile ../config/nvim/plugin/sets.vim;

  xdg.configFile."nvim/init.vim".text = builtins.readFile ../config/nvim/init.vim;

  xdg.configFile."nvim/lua/init.lua".text = builtins.readFile ../config/nvim/lua/init.lua;

  xdg.configFile."nvim/lua/siddhant/keys.lua".text = builtins.readFile ../config/nvim/lua/siddhant/keys.lua;
  xdg.configFile."nvim/lua/siddhant/lualine.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lualine.lua;
  xdg.configFile."nvim/lua/siddhant/nvim-tree.lua".text = builtins.readFile ../config/nvim/lua/siddhant/nvim-tree.lua;
  xdg.configFile."nvim/lua/siddhant/telescope.lua".text = builtins.readFile ../config/nvim/lua/siddhant/telescope.lua;
  xdg.configFile."nvim/lua/siddhant/todo-comments.lua".text = builtins.readFile ../config/nvim/lua/siddhant/todo-comments.lua;
  xdg.configFile."nvim/lua/siddhant/treesitter.lua".text = builtins.readFile ../config/nvim/lua/siddhant/treesitter.lua;
  xdg.configFile."nvim/lua/siddhant/utils/init.lua".text = builtins.readFile ../config/nvim/lua/siddhant/utils/init.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/cmp.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/cmp.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/custom_attach.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/custom_attach.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/init.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/init.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/json.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/json.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/svelte.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/svelte.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/tabnine.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/tabnine.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/diagnosticls.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/diagnosticls.lua;
}
