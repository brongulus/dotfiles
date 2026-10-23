#!/bin/sh

xsetroot -solid "#121212"

kanata -n -c ~/dotfiles/kanata/.config/kanata/void.kbd > /tmp/kanata.log 2>&1 &
devmon --no-gui &
xrdb -merge ~/.Xresources &
xset r rate 250 40
pipewire &
pipewire-pulse &
# volumeicon &

exec dbus-run-session i3
