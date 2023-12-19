[ -e /etc/ksh.kshrc ] && . /etc/ksh.kshrc

export PAGER=less
export EDITOR=nvim
export HISTFILE=$HOME/.ksh_history
export PATH=$PATH:$HOME/bin:$HOME/Apps/bin

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

#gls is required to be installed via pkg_add -v coreutils
alias ls='gls --color=auto'
alias ll='gls --color=auto -a -l -h'
alias la='gls --color=auto -a'
alias netcheck='systat if 1'
alias vim='TERM=xterm-256color vim'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias git='TERM=xterm-256color git'
alias vim=nvim

bind "^[[3~"=delete-char-forward

if [ $TERM = 'vt220' ];then
	export TERM=wsvt25
elif [ $TERM = 'xterm-256color' ];then
	export TERM=xterm
fi

if [ $USER = 'root' ];then
    export PS1=$'\a\r\a\e[31m\a\u@\h\a\e[34m\a | \a\e[0;33m\a\w\a\e[1;34m\a |\n | \a\e[32m\a$(date +%H:%M:%S)\a\e[34m\a | >>\a\e[0m\a '
else	
    export PS1=$'\a\r\a\e[36m\a\u@\h\a\e[34m\a | \a\e[0;33m\a\w\a\e[1;34m\a |\n | \a\e[32m\a$(date +%H:%M:%S)\a\e[34m\a | >>\a\e[0m\a '
fi

set -o csh-history
set -o emacs

# Try to start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

fortune | cowsay
