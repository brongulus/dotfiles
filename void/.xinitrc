#!/bin/sh

hsetroot -solid "#121212"

kanata -n -c ~/dotfiles/kanata/.config/kanata/void.kbd > /tmp/kanata.log 2>&1 &
devmon --no-gui &
xrdb -merge ~/.Xresources &
pipewire &
pipewire-pulse &
dunst &
feh --bg-scale ~/dotfiles/void/lake.jpg &

exec dbus-run-session -- i3
