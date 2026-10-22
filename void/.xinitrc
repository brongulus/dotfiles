#!/bin/sh

xsetroot -solid "#121212"

kanata -n -c ~/dotfiles/kanata/.config/kanata/void.kbd > /tmp/kanata.log 2>&1 &
exec bspwm
