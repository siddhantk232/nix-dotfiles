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

# custom scripts
set -x PATH $PATH ~/nix-dotfiles/users/sidd/config/scripts

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

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 33467c
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection


