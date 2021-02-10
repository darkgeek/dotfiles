if uname | grep -i openbsd > /dev/null
    # Change terminal type
    if test $TERM = 'vt220'
        set -x TERM wsvt25
    end

    # Set PATH
    set -x PATH $PATH /usr/games /usr/local/jdk-1.8.0/bin/

    # Set alias 
    alias ls='gls --color=auto'
    alias ll='gls --color=auto -a -l -h'
    alias la='gls --color=auto -a'

    # Do not save core files
    ulimit -c 0
end
