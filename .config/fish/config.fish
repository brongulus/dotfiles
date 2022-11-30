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

    set FZF_DEFAULT_OPTS "--color=bg+:#3B4252,border:#D8DEE9,bg:#263238,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"

    function fzf-open
       set -l file
       set file (fzf --height 60% --border --reverse) &&
       setsid xdg-open "$file" &
    end

    bind \cf 'fzf-open &'

    bind \cp 'xclip -o'

end
