# clears fish welcome message
set fish_greeting

# environment variables 
set -x EDITOR nvim
set -x BROWSER brave
set -x TERM st
set -x LC_ALL en_US.UTF-8
set -x BAT_THEME gruvbox-dark
set -x PATH $PATH ~/.dotfiles/users/sidd/config/scripts

# config aliases (all lowercase and starts with c)
alias config "nvim ~/.dotfiles"

# aliases for commands
alias r            "./bin/rails"
alias e            "nvim"
alias ls           "lsd"
alias tmux         "tmux -2" # force 256 color
alias ph           "kdeconnect-cli -d f9118946111fd280"

# keybinds
bind -M insert \cp 'sessions'
bind -M insert \ce 'pdfs'

# enable vi
fish_vi_key_bindings

