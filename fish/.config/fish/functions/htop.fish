function htop
    if command -sq termux-info
        # if in Termux environment, sudo is required to run htop
        command sudo htop $argv
    else
        command htop $argv
    end
end
