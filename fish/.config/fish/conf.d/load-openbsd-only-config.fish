if uname | grep -i openbsd > /dev/null
    # Change terminal type
    if test $TERM = 'vt220'
        set -x TERM wsvt25
    end

    # Set PATH
    set -x PATH $PATH /usr/local/jdk-1.8.0/bin/

    # Set alias 
    alias ls='gls --color=auto'
    alias ll='gls --color=auto -a -l -h'
    alias la='gls --color=auto -a'
end
