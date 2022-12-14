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

# Auto CD
shopt -s autocd

# History
export HISTSIZE=20000
export HISTCONTROL=erasedups

export ANKI_BASE="/mnt/Data/AnkiData"

# Fix Matlab
export _JAVA_AWT_WM_NONREPARENTING=1

alias matlinux='env LD_PRELOAD=/usr/lib/libstdc++.so.6 /home/prashant/bin/Matlab/bin/matlab -desktop'

# Add this to your .bashrc, .zshrc or equivalent.
# Run 'fff' with 'f' or whatever you decide to name the function.
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

export FFF_FAV1=~
export FFF_FAV2=~/.bashrc
export FFF_FAV3=/mnt/Data/Documents
export FFF_FAV4=/mnt/manjaro/home/prashant/Downloads/Media
export FFF_FAV5=/
export FFF_FAV6=
export FFF_FAV7=
export FFF_FAV8=
export FFF_FAV9=

export EDITOR="nvim"

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

# arcticicestudio/nord-vim
export FZF_DEFAULT_COMMAND="find -L"
export FZF_DEFAULT_OPTS='--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1'

fzf-open(){
 file="$(fzf --height 40% --reverse)" && [ -f "$file" ] && xdg-open "$file"
}

bind -x '"\C-xf": fzf-open'

# FFF
export FFF_KEY_MKDIR="+"
export FFF_COL2=0
export FFF_COL5=7
export FFF_KEY_PARENT4="-"

### File operations.

export FFF_KEY_YANK="y"
export FFF_KEY_MOVE="m"
export FFF_KEY_TRASH="d"
export FFF_KEY_LINK="s"
export FFF_KEY_BULK_RENAME="b"

export FFF_KEY_YANK_ALL="Y"
export FFF_KEY_MOVE_ALL="M"
export FFF_KEY_TRASH_ALL="D"
export FFF_KEY_LINK_ALL="S"
export FFF_KEY_BULK_RENAME_ALL="B"

export FFF_KEY_PASTE="p"
export FFF_KEY_CLEAR="c"

export FFF_KEY_RENAME="r"
# export FFF_KEY_MKDIR="n"
export FFF_KEY_MKFILE="f"
export FFF_KEY_IMAGE="i" # display image with w3m-img

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
	_direnv_hook__old "$@" 2> >(egrep -v '^direnv: (export)')
}
# Nix Shiz
# export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels

# fish
exec fish
