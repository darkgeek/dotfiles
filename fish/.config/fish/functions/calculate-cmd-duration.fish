# Fork from https://github.com/IlanCosman/tide/blob/main/functions/_tide_right_prompt.fish
function calculate-cmd-duration
    set -l seconds (math --scale=$cmd_duration_decimals "$CMD_DURATION/1000" % 60)
    set -l minutes (math --scale=0 "$CMD_DURATION/60000" % 60)
    set -l hours (math --scale=0 "$CMD_DURATION/3600000")

    if test $hours -gt 0
        printf '%s' $hours'h ' $minutes'm ' $seconds's'
    else if test $minutes -gt 0
        printf '%s' $minutes'm ' $seconds's'
    else if test $seconds -gt 0
        printf '%s' $seconds's'
    end
end
