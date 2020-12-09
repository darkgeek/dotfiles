function sudo
    if command -qs doas 
        command doas $argv
    else if command -qs sudo
        command sudo $argv
    else 
        echo "Neighter doas nor sudo is installed."
    end
end
