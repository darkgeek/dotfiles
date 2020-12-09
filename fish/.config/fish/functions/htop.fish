function htop
    if command -sq termux-info
        # if in Termux environment, sudo is required to run htop
        sudo htop $argv
    else
        htop $argv
    end
end
