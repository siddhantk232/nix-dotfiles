syntax on

set exrc
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set relativenumber
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hidden
set nohlsearch
set scrolloff=8
set signcolumn=yes
set completeopt=menuone,noinsert,noselect

" enable mouse in NORMAL and VISUAL. Good for presenting purposes!
set mouse=nv

" https://github.com/morhetz/gruvbox/wiki/Terminal-specific#0-recommended-neovimvim-true-color-support
set termguicolors

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80

" spellcheck
set spelllang=en_us
set spellsuggest=best,9

lua require'colorizer'.setup()
