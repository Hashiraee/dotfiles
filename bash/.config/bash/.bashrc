# ====================
# Basic Configuration
# ====================

# Check window size after each command
shopt -s checkwinsize

# Enable extended pattern matching
shopt -s extglob

# Show all matches immediately on first Tab press
bind 'set show-all-if-ambiguous on'

# Optional: Show all matches without partial completion
bind 'set show-all-if-unmodified on'

# Don't cycle through options (disable menu-complete)
bind 'TAB:complete'


# ====================
# History Configuration
# ====================

# Don't store duplicate lines or lines starting with space
HISTCONTROL=ignoreboth:erasedups

# Don't record some common commands
HISTIGNORE="ls:la:ll:clear:tmux_attach"

# Large history size
HISTSIZE=20000
HISTFILESIZE=20000
HISTFILE=~/.bash_history

# History behavior settings
shopt -s histappend

# Store multi-line commands in one history entry
shopt -s cmdhist      

# Immediately append commands to history and reload history after each command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ====================
# Aliases
# ====================

# Color support aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Common aliases
alias ll='eza -l'
alias la='eza -al'
alias vim='nvim'
alias k='kubectl'
alias sourcebashrc='source ~/.bashrc'
alias cnvim='cd ~/.config/nvim'
alias cortecgpt='cd ~/Workspace/dev.azure.com/ORTEC-Scientific/ORTEC-GPT/ortecgpt'

# Change Directory to root of Git project
alias gcd='cd $(git rev-parse --show-toplevel)'

# ====================
# Functions
# ====================

function tmux_attach() {
    if [[ -n "$TMUX" ]]; then
        session=$(tmux list-sessions -F "#{session_name}" | fzf --exit-0 --reverse --header 'Select Session')
        if [[ -n "$session" ]]; then
            tmux switch-client -t "$session"
        fi
    else
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --reverse --header 'Select Session')
        if [[ -n "$session" ]]; then
            tmux attach -t "$session"
        fi
    fi
}

bind '"\C-p":"\C-utmux_attach\n"' 2>/dev/null


function dircopy() {
    local dir="${1:-.}"  # Use provided directory or current directory (.)
    local index=1
    
    # Start XML
    echo "<documents>"
    
    # Use ripgrep to find all files, excluding hidden files
    rg --files "$dir" | while read -r file; do
        echo "  <document index=\"$index\">"
        echo "    <source>$file</source>"
        echo "    <document_content>"
        while IFS= read -r line; do
            if [[ -n "$line" ]]; then  # If line is not empty
                printf "      %s\n" "$line"
            else
                echo "      "  # For empty lines
            fi
        done < "$file"
        echo "    </document_content>"
        echo "  </document>"
        ((index++))
    done
    
    # End XML
    echo "</documents>"
}


function workspace() {
    function get_repos() {
        find ~/Workspace/dev.azure.com -mindepth 3 -maxdepth 3 -type d | sed 's|'"$HOME"'/Workspace/||'
        find ~/Workspace/github.com -mindepth 2 -maxdepth 2 -type d | sed 's|'"$HOME"'/Workspace/||'
    }

    function create_or_switch_session() {
        local repo_path="$1"
        
        # Custom session naming based on the path
        local session_name
        if [[ $repo_path == github.com/* ]]; then
            session_name=$(echo "$repo_path" | sed 's|github.com/Hashiraee/||')
        else
            session_name=$(echo "$repo_path" | sed 's|dev.azure.com/||')
        fi
        
        # Replace slashes and dots with hyphens in the session name
        session_name=$(echo "$session_name" | tr '/' '_' | tr '.' '_')
        
        # Check if session exists
        if tmux has-session -t "$session_name" 2>/dev/null; then
            if [[ -n "$TMUX" ]]; then
                tmux switch-client -t "$session_name"
            else
                tmux attach-session -t "$session_name"
            fi
        else
            # Session doesn't exist - create new one with 4 windows
            tmux new-session -d -s "$session_name" -c "$HOME/workspace/$repo_path"
            for i in {2..4}; do
                tmux new-window -t "$session_name" -c "$HOME/workspace/$repo_path"
            done
            tmux select-window -t "$session_name:1"
            
            if [[ -n "$TMUX" ]]; then
                tmux switch-client -t "$session_name"
            else
                tmux attach-session -t "$session_name"
            fi
        fi
    }

    # Main execution
    selected_repo=$(get_repos | fzf --height 40% --reverse)

    if [[ -n "$selected_repo" ]]; then
        create_or_switch_session "$selected_repo"
    fi
}

# Bind Ctrl+O to the workspace function
bind -x '"\C-o":"workspace"' 2>/dev/null


# ====================
# External Tools & Path
# ====================

# FZF
eval "$(fzf --bash)"

# Kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k

# FluxCD
source <(flux completion bash)

# Path modifications
export PATH="$HOME/.local/bin:$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.rd/bin"

# Editor
export EDITOR=nvim

# Docker
export DOCKER_BUILDKIT=1


# ====================
# Prompt Theme
# ====================

eval "$(starship init bash)"
