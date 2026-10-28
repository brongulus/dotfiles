#!/usr/bin/env bash
set -e

mpd ~/.config/mpd/mpd.conf

dictd -c ~/.dictd.conf --pid-file /tmp/dictd.pid

yabai &

sudo kanata -c ~/dotfiles/kanata/.config/kanata/mac.kbd 
