let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-compe'
" Plug 'akinsho/flutter-tools.nvim'
Plug 'thosakwe/vim-flutter'

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
Plug 'ayu-theme/ayu-vim' 
Plug 'hoob3rt/lualine.nvim'
Plug 'mboughaba/i3config.vim'
Plug 'windwp/nvim-ts-autotag'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mhinz/vim-startify'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/todo-comments.nvim'

" fmt
Plug 'sbdchd/neoformat'

call plug#end()

" lua require('init')

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

inoremap <silent><expr> <CR>      compe#confirm('<CR>')

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
