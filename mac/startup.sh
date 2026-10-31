#!/usr/bin/env bash
set -e

mpd ~/.config/mpd/mpd.conf

dictd -c ~/.dictd.conf --pid-file /tmp/dictd.pid

yabai &

sudo kanata -c ~/dotfiles/common/.config/kanata/mac.kbd 
