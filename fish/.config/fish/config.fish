# export envrionment variables
set -x XMODIFIERS "@im=fcitx"
set -x GTK_IM_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x PATH $PATH /sbin $HOME/Apps/bin $HOME/bin
set -x EDITOR vim
set -x PAGER less
set -x DISPLAY :1

# Alias
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# keybindings
bind !! 'commandline "sudo $history[1]"'

# Load ssh-agent
load-ssh-agent

# OpenBSD only
echo (load-openbsd-only-config) | source

# Termux only
load-termux-only-config

# Eyecandy
fortune | cowsay
