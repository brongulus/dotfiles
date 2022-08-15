#!/usr/bin/env sh

hour=$(echo $(date +r) | cut -d : -f 1)
# hour=19
if [ bc<<<"$hour >= 05" ] && [ bc<<<"$hour <= 18" ]; then
    nitrogen --set-zoom-fill ~/Pictures/unsplash-3.jpg
else
    nitrogen --set-zoom-fill ~/Pictures/macOS-1.jpeg
fi
