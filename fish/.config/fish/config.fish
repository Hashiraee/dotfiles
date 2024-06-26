abbr -a n nvim
abbr -a v vim
abbr -a cnvim cd ~/.dotfiles/nvim/.config/nvim

fish_config theme choose "rosepine"

alias ls="eza"
alias ll="eza -l"
alias la="eza -al"

# Set the cursor shapes for the different vi modes.
# set fish_cursor_default     block      blink
# set fish_cursor_insert      line       blink
# set fish_cursor_replace_one underscore blink
# set fish_cursor_visual      block

if status is-interactive
    # Commands to run in interactive sessions can go here
end
if status is-interactive; and command -q pyenv; pyenv init - | source ; end
