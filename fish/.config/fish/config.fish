# Source system profile, see more: https://wiki.gentoo.org/wiki/Fish
bass source /etc/profile

# export envrionment variables
set -x XMODIFIERS "@im=fcitx"
set -x GTK_IM_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x EDITOR vim
set -x PATH $PATH /sbin /usr/sbin /usr/pkg/sbin $HOME/Apps/bin $HOME/bin $HOME/.cargo/bin $HOME/.local/bin /usr/games /usr/pkg/java/openjdk8/bin /boot/dietpi /boot/dietpi/misc /boot/dietpi/func
set -x PAGER less

# Alias
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# keybindings
bind !! 'commandline "sudo $history[1]"'

# Only when in tty
if isatty && status is-interactive
    # Load ssh-agent
    load-ssh-agent

    # Eyecandy
    fortune | cowsay
end
