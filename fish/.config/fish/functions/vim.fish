function vim
    if command -qs nvim
        command nvim $argv
    else if command -qs vim
        command vim $argv
    else if command -qs vi
        command vi $argv
    else if command -qs neatvi
        command neatvi $argv
    else
        echo "No vi implementation installed."
    end
end
