function netcheck
    if uname | egrep -i 'linux|darwin' > /dev/null
        command nload -u K
    else if uname | grep -i openbsd > /dev/null
        command systat if 1
    end
end
