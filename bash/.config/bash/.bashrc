# =============================================================================
# ~/.bashrc - Interactive shell configuration
# =============================================================================

# If not running interactively, don't do anything
[[ -z $PS1 ]] && return

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

# Locale
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

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
alias tree='eza -T'
alias gtree='eza --git-ignore -T'
alias cat='bat'

# Editors
alias vi='nvim'
alias vim='nvim'

# Git
alias gs='git status'
alias gl='git --no-pager log --oneline --decorate --graph -n 32'
alias glr='git --no-pager log --oneline --decorate --reverse'
alias gcd='cd $(git rev-parse --show-toplevel)'

# Kubernetes
alias k='kubectl'
alias kb='kustomize build'

# Quick access
alias cnvim='cd ~/.config/nvim'

# =============================================================================
# Functions
# =============================================================================

# ------------------------------------
# Decode jwt tokens
# ------------------------------------
jwt() {
  jq -R 'split(".")[0:2][]
         | gsub("-";"+") | gsub("_";"/")
         | @base64d | fromjson
         | if .iat? then .iat_date = (.iat | todate) else . end
         | if .exp? then .exp_date = (.exp | todate) else . end' <<< "${1:-$(cat)}"
}

# ------------------------------------
# Copy directory contents as XML
# ------------------------------------
dircopy() {
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
tmux_attach() {
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
workspace() {
    get_repos() {
        find ~/Workspace/dev.azure.com -mindepth 3 -maxdepth 3 -type d | sed 's|'"$HOME"'/Workspace/||'
        find ~/Workspace/github.com -mindepth 2 -maxdepth 2 -type d | sed 's|'"$HOME"'/Workspace/||'
    }

    create_or_switch_session() {
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
            # Session doesn't exist - create new one with 3 windows
            tmux new-session -d -s "$session_name" -c "$HOME/workspace/$repo_path"
            for i in {2..3}; do
                tmux new-window -t "$session_name" -c "$HOME/workspace/$repo_path"
            done
            tmux select-window -t "$session_name:2"
            
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

# ------------------------------------
# Cloud credential loaders
# ------------------------------------
anthropic() {
    local instance="${1:-claude}"
    local credentials

    credentials=$(pass "azure/${instance}" 2>/dev/null) || {
        echo "No credentials found for instance: $instance" >&2
        return 1
    }

    export CLAUDE_CODE_USE_FOUNDRY=1
    export ANTHROPIC_FOUNDRY_BASE_URL=$(jq -r '.ANTHROPIC_FOUNDRY_BASE_URL' <<< "$credentials")
    export ANTHROPIC_FOUNDRY_API_KEY=$(jq -r '.ANTHROPIC_FOUNDRY_API_KEY' <<< "$credentials")
    export ANTHROPIC_SMALL_FAST_MODEL='claude-haiku-4-5'
    export ANTHROPIC_DEFAULT_HAIKU_MODEL='claude-haiku-4-5'
    export ANTHROPIC_DEFAULT_SONNET_MODEL='claude-sonnet-5[1m]'
    export ANTHROPIC_DEFAULT_OPUS_MODEL='claude-opus-5[1m]'
    export ANTHROPIC_MODEL="claude-fable-5[1m]"
}

azure() {
    local instance="${1:-foundry}"
    local credentials

    credentials=$(pass "azure/${instance}" 2>/dev/null) || {
        echo "No credentials found for instance: $instance" >&2
        return 1
    }

    export AZURE_OPENAI_BASE_URL=$(jq -r '.AZURE_OPENAI_BASE_URL' <<< "$credentials")
    export AZURE_OPENAI_ENDPOINT=$(jq -r '.AZURE_OPENAI_ENDPOINT' <<< "$credentials")
    export AZURE_OPENAI_API_KEY=$(jq -r '.AZURE_OPENAI_API_KEY' <<< "$credentials")
}

bedrock() {
    local region="${1:-eu}"
    local credentials

    credentials=$(pass "aws/region-${region}" 2>/dev/null) || {
        echo "No credentials found for profile: $region" >&2
        return 1
    }

    export CLAUDE_CODE_USE_BEDROCK=1
    export AWS_DEFAULT_REGION=$(jq -r '.region' <<< "$credentials")
    export AWS_ACCESS_KEY_ID=$(jq -r '.access_key' <<< "$credentials")
    export AWS_SECRET_ACCESS_KEY=$(jq -r '.secret_key' <<< "$credentials")
    export ANTHROPIC_SMALL_FAST_MODEL="${region}.anthropic.claude-haiku-4-5-20251001-v1:0"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="${region}.anthropic.claude-haiku-4-5-20251001-v1:0"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="${region}.anthropic.claude-sonnet-5[1m]"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="${region}.anthropic.claude-opus-5[1m]"
    export ANTHROPIC_MODEL="global.anthropic.claude-fable-5[1m]"
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

# Large tmux popup (90% wide, 70% tall)
export FZF_TMUX_OPTS="-p90%,70%"

# Classic bottom-up layout, border, inherit terminal's ANSI colors
export FZF_DEFAULT_OPTS="--layout=default --border --no-scrollbar"

# fd as the finder
export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --strip-cwd-prefix"

# Ctrl+T: always-visible file preview on the right
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}' --preview-window=right,50%"

# Alt+C: plain directory list, no preview
export FZF_ALT_C_OPTS="--no-preview"

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
