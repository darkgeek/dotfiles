function sudo-last --on-event fish_postexec
    set SUDO_CMD sudo
    if command -q doas
        set SUDO_CMD doas
    end
    abbr !! $SUDO_CMD $argv[1]
end
