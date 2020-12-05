function netcheck
    if uname | grep -i linux > /dev/null
        command nload -u K
    else if uname | grep -i openbsd > /dev/null
        command systat if 1
    end
end
