function load-termux-only-config
    if ! command -q termux-info
        return
    end

    command xhost +local: > /dev/null
end
