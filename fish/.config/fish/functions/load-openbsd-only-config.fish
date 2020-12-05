function load-openbsd-only-config
    set export_vars ""

    if ! uname | grep -i openbsd
        return
    end

    # Change terminal type
    if test $TERM = 'vt220'
        set export_vars $export_vars "set -x TERM wsvt25;"
    end

    # Set PATH
    set export_vars $export_vars "set -x PATH $PATH /usr/local/jdk-1.8.0/bin/;"
    # Set alias 
    set export_vars $export_vars "alias ls='gls --color=auto';"
    set export_vars $export_vars "alias ll='gls --color=auto -a -l -h';"
    set export_vars $export_vars "alias la='gls --color=auto -a';"

    echo $export_vars
end
