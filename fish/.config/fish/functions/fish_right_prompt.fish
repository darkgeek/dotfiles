function fish_right_prompt
    set -x cmd_duration_threshold 5000
    set -x cmd_duration_decimals 3

    set -l duration (calculate-cmd-duration)

    if test -n "$duration"
        set_color cyan
        echo "⌚$duration"
    end
end
