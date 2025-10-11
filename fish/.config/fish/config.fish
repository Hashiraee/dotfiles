if status is-interactive
    set fish_greeting ""
    set -x EDITOR nvim
    set -x STARSHIP_CONFIG ~/.config/starship/fish/starship.toml 

    # Abbreviations    
    abbr k 'kubectl'
    
    # Aliases
    alias vim 'nvim'


    starship init fish | source
end
