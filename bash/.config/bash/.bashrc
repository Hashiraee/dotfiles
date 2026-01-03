# =============================================================================
# ~/.bashrc - Interactive shell configuration
# =============================================================================

# If not running interactively, don't do anything
[[ -z $PS1 ]] && return
# [[ $- != *i* ]] && return

# =============================================================================
# Homebrew (must be first - other tools depend on it)
# =============================================================================

eval "$(/opt/homebrew/bin/brew shellenv)"

# =============================================================================
# PATH Configuration
# =============================================================================

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# =============================================================================
# Environment Variables
# =============================================================================

# Editor
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Docker
export DOCKER_BUILDKIT=1

# Kubectl
export KUBECTL_EXTERNAL_DIFF="delta"

# NVM
export NVM_DIR="$HOME/.nvm"

# Support colors in less
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# =============================================================================
# Shell Options
# =============================================================================

shopt -s checkwinsize   # Update LINES and COLUMNS after each command
shopt -s extglob        # Extended pattern matching
shopt -s globstar       # Recursive globbing with **
shopt -s histappend     # Append to history, don't overwrite
shopt -s cmdhist        # Store multi-line commands in one entry

# =============================================================================
# History Configuration
# =============================================================================

HISTCONTROL=erasedups:ignorespace
HISTIGNORE="ls:la:ll:clear:tmux_attach"
HISTSIZE=50000
HISTFILESIZE=50000
HISTFILE=~/.bash_history

# Sync history across sessions: append
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# =============================================================================
# Readline Configuration
# =============================================================================

bind 'set show-all-if-ambiguous on'
bind 'set show-all-if-unmodified on'
bind 'TAB:complete'

# =============================================================================
# Aliases
# =============================================================================

# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Listing (eza)
alias ll='eza -l'
alias la='eza -al'

# Editors
alias vi='nvim'
alias vim='nvim'

# Git
alias gl='git --no-pager log --oneline --decorate --graph -n 32'
alias glr='git --no-pager log --oneline --decorate --reverse'
alias gcd='cd $(git rev-parse --show-toplevel)'

# Kubernetes
alias k='kubectl'
alias kz='kustomize build'

# Quick access
alias sourcebashrc='source ~/.bashrc'
alias cnvim='cd ~/.config/nvim'

# =============================================================================
# Functions
# =============================================================================

# ------------------------------------
# Copy directory contents as XML
# ------------------------------------
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

# ------------------------------------
# Tmux session selector (Ctrl+P)
# ------------------------------------
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

# ------------------------------------
# Workspace session manager (Ctrl+O)
# ------------------------------------
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

# =============================================================================
# Tool Initializations
# =============================================================================

# NVM
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
    source "/opt/homebrew/opt/nvm/nvm.sh"
fi

# FZF
eval "$(fzf --bash)"

# =============================================================================
# Completions
# =============================================================================

# Homebrew managed completions
if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
    source "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

# NVM
if [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]]; then
    source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

# Kubectl (with alias support)
source <(kubectl completion bash)
complete -F __start_kubectl k

# FluxCD
source <(flux completion bash)

# =============================================================================
# Key Bindings
# =============================================================================

bind '"\C-p":"\C-utmux_attach\n"' 2>/dev/null
bind -x '"\C-o":"workspace"' 2>/dev/null

# =============================================================================
# Prompt
# =============================================================================

eval "$(starship init bash)"
