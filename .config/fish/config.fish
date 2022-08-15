if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    # Aliases
    if [ -f $HOME/.config/alias ]
    source $HOME/.config/alias
    end
end
