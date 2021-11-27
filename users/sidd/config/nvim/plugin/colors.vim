" https://github.com/awesome-streamers/awesome-streamerrc/blob/master/ThePrimeagen/plugin/colors.vim

fun! SetColors()
  colorscheme gruvbox
  set background=dark
  " let ayucolor="dark"
  let g:gruvbox_contrast_dark = 'hard'
  
  if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif

  let g:gruvbox_invert_selection='0'
endfun

call SetColors()

nnoremap <leader>col :call SetColors()<CR>

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * highlight SignColumn guibg=NONE
