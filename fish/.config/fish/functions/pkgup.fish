function pkgup
    if command -q termux-info
        # if in Termux environment, use pkg
        command pkg up -y $argv
    else if uname | grep -i openbsd 
        command doas pkg_add -uv
    else if command -q brew
        command brew update && brew upgrade
    else if command -q pacman 
        command pkgup
    else if command -q apt 
        command sudo apt update && sudo apt upgrade
    end
end
