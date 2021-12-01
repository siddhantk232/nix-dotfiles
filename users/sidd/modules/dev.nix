{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ../config/nvim/init.vim;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nlua-nvim
      lsp_extensions-nvim
      nvim-compe
      vim-flutter

      popup-nvim
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))

      undotree
      emmet-vim
      vim-devicons
      nvim-web-devicons
      tabular

      vim-commentary
      vim-fugitive
      vim-surround

      gruvbox-community
      lualine-nvim
      i3config-vim
      nvim-colorizer-lua
      vim-startify
      nvim-tree-lua
      todo-comments-nvim
      neoformat
    ];
  };

  xdg.configFile."nvim/plugin/colors.vim".text = builtins.readFile ../config/nvim/plugin/colors.vim;
  xdg.configFile."nvim/plugin/sets.vim".text = builtins.readFile ../config/nvim/plugin/sets.vim;

  xdg.configFile."nvim/lua/init.lua".text = builtins.readFile ../config/nvim/lua/init.lua;
  xdg.configFile."nvim/lua/siddhant/keys.lua".text = builtins.readFile ../config/nvim/lua/siddhant/keys.lua;
  xdg.configFile."nvim/lua/siddhant/lualine.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lualine.lua;
  xdg.configFile."nvim/lua/siddhant/nvim-tree.lua".text = builtins.readFile ../config/nvim/lua/siddhant/nvim-tree.lua;
  xdg.configFile."nvim/lua/siddhant/telescope.lua".text = builtins.readFile ../config/nvim/lua/siddhant/telescope.lua;
  xdg.configFile."nvim/lua/siddhant/todo-comments.lua".text = builtins.readFile ../config/nvim/lua/siddhant/todo-comments.lua;
  xdg.configFile."nvim/lua/siddhant/treesitter.lua".text = builtins.readFile ../config/nvim/lua/siddhant/treesitter.lua;
  xdg.configFile."nvim/lua/siddhant/utils/init.lua".text = builtins.readFile ../config/nvim/lua/siddhant/utils/init.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/compe.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/compe.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/custom_attach.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/custom_attach.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/init.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/init.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/json.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/json.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/svelte.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/svelte.lua;


  # Fish config
  xdg.configFile."fish/config.fish".text = builtins.readFile ../config/fish/config.fish;

  # Tmux 
  home.file.".tmux.conf".text = builtins.readFile ../config/tmux.conf;
}
