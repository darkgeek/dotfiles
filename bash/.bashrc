#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -a -l -h'
alias la='ls --color=auto -a'
alias cp='cp -i'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias netcheck="nload -u K"
alias feh="feh -F"
alias showtemp="cat /sys/devices/virtual/thermal/thermal_zone0/temp"
export EDITOR='vim'
export PATH=$PATH:$HOME/Apps/bin:/usr/games

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

#export GDK_SCALE=1.9
#export GDK_DPI_SCALE=1.9

# Bind Ctrl-Left and Ctrl-Right to word jumping in line editing
bind '"\e[1;5D": shell-backward-word'
bind '"\e[1;5C": shell-forward-word'

# Try to start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

fortune | cowsay
