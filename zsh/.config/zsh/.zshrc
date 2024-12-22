# ====================
# History Configuration
# ====================
setopt appendhistory
export HISTSIZE=10000
export SAVEHIST=10000

# ====================
# Path Configuration
# ====================
# Ensure PATH is only set once with all necessary directories
export PATH="/Users/hasanisraeli/.local/bin:\
/Users/hasanisraeli/.local/share/bob/nvim-bin:\
$PYENV_ROOT/bin:\
$HOME/go/bin:\
$PATH"

# ====================
# Plugin/Tool Initialization
# ====================
# Colors and completion
autoload -Uz colors && colors
autoload -U compinit && compinit

# PyEnv initialization
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# FZF
eval "$(fzf --zsh)"

# External plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ====================
# Kubernetes Configuration
# ====================
source <(kubectl completion zsh)
alias k=kubectl
compdef __start_kubectl k

# ====================
# Tmux Functions
# ====================
function tmux_attach() {
    local session
    if [[ -n "$TMUX" ]]; then
        session=$(tmux list-sessions -F "#{session_name}" | fzf --exit-0 --reverse --header 'Select Session')
        [[ -n "$session" ]] && tmux switch-client -t "$session"
    else
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --reverse --header 'Select Session')
        [[ -n "$session" ]] && tmux attach -t "$session"
    fi
}

function tmux_attach_widget() {
    BUFFER="tmux_attach"
    zle accept-line
}

zle -N tmux_attach_widget
bindkey '^P' tmux_attach_widget

# ====================
# Aliases
# ====================
# File listing
alias ls="eza"
alias ll="eza -l"
alias la="eza -al"

# Navigation and configuration
alias sourcezsh="source ~/.zshrc"
alias cnvim="cd ~/.dotfiles/nvim/.config/nvim"

# ====================
# Starship
# ====================
# Prompt
eval "$(starship init zsh)"
