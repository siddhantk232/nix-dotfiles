{ config, pkgs, ... }:
let
  cmp-npm = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-npm";
    src = pkgs.fetchFromGitHub {
      owner = "David-Kunz";
      repo = "cmp-npm";
      rev = "4b6166c3feeaf8dae162e33ee319dc5880e44a29";
      sha256 = "QggQ+axMaFcUCt2gfSpsDpM0YlxEkAiDCctzfYtceVI=";
    };
  };
  cmp-rg = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-rg";
    src = pkgs.fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "cmp-rg";
      rev = "7a95aa7eefceed1eac6907889d1d8812b6b051d4";
      sha256 = "K41dW1QpiOEFPEFOHpHLdB0nJFkshH+Z7D9KyD2S2oM=";
    };
  };
in
{
  home.packages = with pkgs; [
    tmux
    tldr
    awscli2

    # code formatters
    luaformatter
    pgformatter
    haskellPackages.cabal-fmt
    haskellPackages.stylish-haskell
    nodePackages.prettier
    nixpkgs-fmt
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ../config/nvim/init.vim;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-buffer
      cmp-npm
      cmp-rg
      cmp-calc
      cmp-spell
      cmp-path
      cmp-cmdline
      lsp_extensions-nvim

      luasnip
      cmp_luasnip

      nlua-nvim

      vim-flutter

      popup-nvim
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      (nvim-treesitter.withPlugins
        (_: builtins.filter
          (x: x.pname != "tree-sitter-markdown-grammar")
          pkgs.tree-sitter.allGrammars))

      undotree
      emmet-vim
      vim-devicons
      nvim-web-devicons
      tabular

      vim-commentary
      vim-fugitive
      vim-surround

      indent-blankline-nvim
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
  xdg.configFile."nvim/lua/siddhant/lsp/cmp.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/cmp.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/custom_attach.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/custom_attach.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/init.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/init.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/json.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/json.lua;
  xdg.configFile."nvim/lua/siddhant/lsp/svelte.lua".text = builtins.readFile ../config/nvim/lua/siddhant/lsp/svelte.lua;


  # Fish config
  xdg.configFile."fish/config.fish".text = builtins.readFile ../config/fish/config.fish;
  xdg.configFile."fish/fish_plugins".text = builtins.readFile ../config/fish/fish_plugins;
  xdg.configFile."fish/fish_variables".text = builtins.readFile ../config/fish/fish_variables;

  xdg.configFile."fish/completions/fisher.fish".text = builtins.readFile ../config/fish/completions/fisher.fish;
  xdg.configFile."fish/completions/sdk.fish".text = builtins.readFile ../config/fish/completions/sdk.fish;
  xdg.configFile."fish/conf.d/sdk.fish".text = builtins.readFile ../config/fish/conf.d/sdk.fish;

  xdg.configFile."fish/functions/fisher.fish".text = builtins.readFile ../config/fish/functions/fisher.fish;
  xdg.configFile."fish/functions/fish_ssh_agent.fish".text = builtins.readFile ../config/fish/functions/fish_ssh_agent.fish;
  xdg.configFile."fish/functions/sdk.fish".text = builtins.readFile ../config/fish/functions/sdk.fish;

  # Tmux 
  home.file.".tmux.conf".text = builtins.readFile ../config/tmux.conf;
}
