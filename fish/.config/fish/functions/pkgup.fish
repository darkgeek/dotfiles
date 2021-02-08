function pkgup
    if command -qs termux-info
        # if in Termux environment, use pkg
        command pkg up -y $argv
    else if uname | grep -i openbsd > /dev/null
        doas pkg_add -uv
    else if command -qs brew
        command brew update && brew upgrade
    else if command -qs pacman 
        command pkgup
    else if command -qs apt 
        sudo apt update -y && sudo apt upgrade -y
    end

    if command -qs fwupdmgr
        fwupdmgr refresh && fwupdmgr get-updates && fwupdmgr update
    end
end
