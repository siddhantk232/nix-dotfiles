# clears fish welcome message
set fish_greeting

# environment variables 
set -x EDITOR nvim
set -x BROWSER brave
set -x TERM st
set -x LC_ALL en_US.UTF-8
set -x BAT_THEME gruvbox-dark
set -x PATH $PATH ~/bin
set -x PATH $PATH /opt/android-studio/bin
set -x PATH $PATH ~/flutter/bin

# config aliases (all lowercase and starts with c)
alias config "nvim ~/projects/.dotfiles"
# Shortcut to setup a nix-shell with fish. This lets you do something like
# `fnix -p go` to get an environment with Go but use the fish shell along
# with it.
alias fnix "nix-shell --run fish"

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

fish_ssh_agent
