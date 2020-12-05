function netcheck
    if uname | grep -i linux
        command nload -u K
    else if uname | grep -i openbsd
        command systat if 1
    end
end
