function pkgup
    if command -qs termux-info
        # if in Termux environment, use pkg
        command pkg upgrade -y $argv
    else if uname | grep -i openbsd > /dev/null
        doas pkg_add -uv
    else if command -qs brew
        command brew update && brew upgrade
    else if command -qs pacman 
        command pkgup
    else if command -qs zypper
        sudo zypper --non-interactive update
    else if command -qs apt 
        sudo apt update -y && sudo apt upgrade -y
    else if command -qs apk
	    sudo apk update && sudo apk upgrade
    else if command -qs pkgin
        sudo pkgin update && sudo pkgin upgrade -y
    end

    if command -qs fwupdmgr
        fwupdmgr refresh && fwupdmgr get-updates && fwupdmgr update
    end
end
