# clears fish welcome message
set fish_greeting

# environment variables 
set -x EDITOR nvim
set -x BROWSER brave
set -x TERM st
set -x LC_ALL en_US.UTF-8
set -x BAT_THEME gruvbox-dark

# config aliases (all lowercase and starts with c)
alias cfish        "nvim ~/.config/fish/config.fish"
alias ci3          "nvim ~/.config/i3/config"
alias ci3status    "nvim ~/.config/i3status-rust/config.toml"
alias ctmux        "nvim ~/.tmux.conf"
alias csessions    "nvim ~/.config/scripts/sessions"
alias cth          "wal -i ~/Pictures/Wallpapers"

# aliases for commands
alias r            "./bin/rails"
alias e            "nvim"
alias ls           "lsd"
alias cwd          "cd ~/projects/work"
alias tmux         "tmux -2" # force 256 color
alias ph           "kdeconnect-cli -d f9118946111fd280"

# keybinds
# bind -M insert \cr 'sessions'

# enable vi
fish_vi_key_bindings

