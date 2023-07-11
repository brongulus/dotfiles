#
# ~/.bashrc (symlink test)
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# Personal Additions
# Look for uninstalled packages
source /usr/share/doc/pkgfile/command-not-found.bash


export PATH=$PATH:/home/prashant/bin
export PATH=$PATH:/home/prashant/.local/bin
export PATH=$PATH:/home/prashant/.cargo/bin

# Auto CD
shopt -s autocd

# History
export HISTSIZE=20000
export HISTCONTROL=erasedups

export ANKI_BASE="/mnt/Data/AnkiData"

# Fix Matlab
export _JAVA_AWT_WM_NONREPARENTING=1

alias matlinux='env LD_PRELOAD=/usr/lib/libstdc++.so.6 /home/prashant/bin/Matlab/bin/matlab -desktop'

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"

# export TERM="tmux-256color"

export COLORTERM="truecolor"

export STARDICT_DATA_DIR="/mnt/Data/Documents/japanese/Dictionary Stuff/sdcv"

export SDCV_PAGER='less --quit-if-one-screen -RX'

if [ -f $HOME/.config/alias ]; then
    source $HOME/.config/alias
fi

#alias mc='PROMPT_COMMAND="history -a; history -r" mc; history -r'

hd() {
    echo "obase=10; ibase=16; $1" | bc
}
dh() {
    echo "obase=16; ibase=10; $1" | bc
}

# Prompt
# FIXME: using <- or browsing history removes rprompt ;-;
rightprompt()
{
    if [ "${PWD:0:5}" = "/home" ]
    then
        printf "%*s" $(expr $COLUMNS - ${#PWD} + 13)
    else
        printf "%*s" $(expr $COLUMNS - ${#PWD})
    fi
}

# Prompt disabled currently due to mc 
# PS1='\[$(tput sc)\]$(rightprompt)\[\e[7;34m\]\w\[$(tput rc)\]\[\e[1;33m\]~; \[\e[0m\]'
PS1='\[\e[7;34m\]\w\[\e[0m\]\[\e[1;33m\] ❯ \[\e[0m\]'
shopt -s checkwinsize

PATH="/home/prashant/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/prashant/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/prashant/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/prashant/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/prashant/perl5"; export PERL_MM_OPT;

# export FZF_DEFAULT_OPTS='--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1'

fzf-open(){
 file="$(fzf --height 40% --reverse)" && [ -f "$file" ] && xdg-open "$file"
}

# bind -x '"\C-xf": fzf-open'

# lf
lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# SSH + Kitty fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# Direnv
eval "$(direnv hook bash)"

copy_function() {
	test -n "$(declare -f "$1")" || return 
	eval "${_/$1/$2}"
}

copy_function _direnv_hook _direnv_hook__old

_direnv_hook() {
	_direnv_hook__old "$@" 2> >(grep -E -v '^direnv: (export)')
}
# Nix Shiz
# export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels

# Automatically added by the Guix install script.
if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
        PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi

export PATH=$PATH:/home/prashant/.guix-profile/bin
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

# fish
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
    exec fish
fi
