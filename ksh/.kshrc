. /etc/ksh.kshrc

export PAGER=less
export EDITOR=vim
export HISTFILE=$HOME/.ksh_history
export PATH=$PATH:/usr/local/jdk-1.8.0/bin/:$HOME/Apps/bin

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

bind "^[[3~"=delete-char-forward

if [ $TERM = 'vt220' ];then
	export TERM=wsvt25
elif [ $TERM = 'xterm-256color' ];then
	export TERM=xterm
fi

if [ $USER = 'root' ];then
	export PS1='\n\u@\h.\[$(tput setaf 1)\]\l\[$(tput op)\\n🕒 `date "+%m-%d %H:%M:%S"` 👉 \w \\$ '
else	
	export PS1='\n\u@\h.\[$(tput setaf 2)\]\l\[$(tput op)\\n🕒 `date "+%m-%d %H:%M:%S"` 👉 \w \\$ '
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
