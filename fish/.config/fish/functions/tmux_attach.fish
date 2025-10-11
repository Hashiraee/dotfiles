function tmux_attach
    if test -n "$TMUX"
        set -l session (tmux list-sessions -F "#{session_name}" | fzf --exit-0 --reverse --header 'Select Session')
        if test -n "$session"
            tmux switch-client -t "$session"
        end
    else
        set -l session (tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --reverse --header 'Select Session')
        if test -n "$session"
            tmux attach -t "$session"
        end
    end
end
