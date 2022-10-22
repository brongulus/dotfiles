if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    # Aliases
    if [ -f $HOME/.config/alias ]
    source $HOME/.config/alias
    end
    
    set PATH ~/.emacs.d/bin $PATH
    set PATH ~/bin $PATH
    set PATH ~/.cargo/bin $PATH

    function f
        fff $argv
        set -q XDG_CACHE_HOME; or set XDG_CACHE_HOME $HOME/.cache
        cd (cat $XDG_CACHE_HOME/fff/.fff_d)
    end
end
