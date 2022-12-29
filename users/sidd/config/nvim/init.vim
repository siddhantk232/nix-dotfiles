call plug#begin('~/.vim/plugged')

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'
Plug 'creativenull/diagnosticls-configs-nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'lukas-reineke/cmp-rg'
Plug 'David-Kunz/cmp-npm'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-calc'
Plug 'f3fora/cmp-spell'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Neovim Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'mbbill/undotree'
Plug 'mattn/emmet-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'godlygeek/tabular'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" fancy stuff
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim' 
Plug 'hoob3rt/lualine.nvim'
Plug 'mboughaba/i3config.vim'
Plug 'windwp/nvim-ts-autotag'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mhinz/vim-startify'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/todo-comments.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lukas-reineke/headlines.nvim'

" fmt
Plug 'sbdchd/neoformat'

call plug#end()

lua require('init')

let g:neoformat_sql_pg_format = {
            \ 'exe': 'pg_format',
            \ 'args': ['-', '-s 2'],
            \ 'stdin': 1, 
            \ }

let g:neoformat_lua_luaformat = {
            \ 'exe': 'lua-format',
            \ 'args': ['--indent-width=2'],
            \ }

let mapleader                 = " "

" set filetypes as typescriptreact for syntax highlight
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end
