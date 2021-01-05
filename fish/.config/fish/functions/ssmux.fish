function ssmux
    set -l session_name "ssmux-session"
    set -l inventory $argv[1]
    set -l user $argv[2]

    # precheck
    if test -z $user || test -z $inventory
        echo "[Usage] ssmux inventory user"
        return
    end

    # Get hosts to which ssh connects
    set -l hosts (ansible nodes --list-hosts | grep -e '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | sed 's/ //g')
    echo "Hosts: $hosts"

    tmux new -s "$session_name" -n main -d
    tmux new-window -t "$session_name:1" -n ''

    for host in $hosts
        tmux send-keys -t "$session_name:1" "autossh $user@$host" C-m
        # NOTE: need to set layout each time because the window resized
        tmux select-layout -t "$session_name:1" tiled
        tmux split-window -t "$session_name:1"
    end

    # kill last unused pane
    tmux kill-pane -t "$session_name:1"
    tmux select-window -t "$session_name:1"
    tmux set-window-option synchronize-panes on
    tmux -2 attach-session -t "$session_name"
end
