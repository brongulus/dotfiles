# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
. "$HOME/.cargo/env"

if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
    exec startx > /tmp/startx.log 2>&1
fi
