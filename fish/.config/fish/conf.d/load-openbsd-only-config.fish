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

    # Redirect all sounds to remote sndiod: https://not.just-paranoid.net/network-audio-and-sndio/
    set -x AUDIODEVICE "snd@172.24.2.104/0"

    # Do not save core files
    ulimit -c 0
end
