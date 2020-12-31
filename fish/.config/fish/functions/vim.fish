function vim
    if command -qs nvim
        command nvim $argv
    else if command -qs vim
        command vim $argv
    else
        echo "Either neovim or vim should be installed"
    end
end
