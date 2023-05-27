abbr -a n nvim
abbr -a v vim
abbr -a cnvim cd ~/.dotfiles/nvim/.config/nvim

alias ls="exa"
alias ll="exa -l"
alias la="exa -al"

# Set the cursor shapes for the different vi modes.
# set fish_cursor_default     block      blink
# set fish_cursor_insert      line       blink
# set fish_cursor_replace_one underscore blink
# set fish_cursor_visual      block

if status is-interactive
    # Commands to run in interactive sessions can go here
end
