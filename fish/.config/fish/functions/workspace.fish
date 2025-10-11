function __workspace_get_repos
    fd -t d . ~/Workspace/dev.azure.com --mindepth 3 --maxdepth 3 | sed 's|'$HOME'/Workspace/||'
    fd -t d . ~/Workspace/github.com --mindepth 2 --maxdepth 2 | sed 's|'$HOME'/Workspace/||'
end

function __workspace_create_or_switch_session
    set -l repo_path $argv[1]
    
    # Custom session naming based on the path
    set -l session_name
    if string match -q "github.com/*" $repo_path
        set session_name (echo "$repo_path" | sed 's|github.com/Hashiraee/||')
    else
        set session_name (echo "$repo_path" | sed 's|dev.azure.com/||')
    end
    
    # Replace slashes and dots with hyphens in the session name
    set session_name (echo "$session_name" | tr '/' '_' | tr '.' '_')
    
    # Check if session exists
    if tmux has-session -t "$session_name" 2>/dev/null
        if test -n "$TMUX"
            tmux switch-client -t "$session_name"
        else
            tmux attach-session -t "$session_name"
        end
    else
        # Session doesn't exist - create new one with 4 windows
        tmux new-session -d -s "$session_name" -c "$HOME/Workspace/$repo_path"
        for i in (seq 2 4)
            tmux new-window -t "$session_name" -c "$HOME/Workspace/$repo_path"
        end
        tmux select-window -t "$session_name:1"
        
        if test -n "$TMUX"
            tmux switch-client -t "$session_name"
        else
            tmux attach-session -t "$session_name"
        end
    end
end

function workspace
    set -l selected_repo (__workspace_get_repos | fzf --height 40% --reverse)

    if test -n "$selected_repo"
        __workspace_create_or_switch_session "$selected_repo"
    end
end
