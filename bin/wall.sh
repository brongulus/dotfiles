#!/usr/bin/env sh

hour=$(echo $(date +%H))

if [ "$hour" -gt "05" ] && [ "$hour" -lt "18" ]; then
    nitrogen --set-zoom-fill ~/Pictures/macOS-0.jpeg
else
    nitrogen --set-zoom-fill ~/Pictures/macOS-1.jpeg
fi
