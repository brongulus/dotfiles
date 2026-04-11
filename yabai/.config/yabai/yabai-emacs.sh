#!/bin/bash

data=$(yabai -m query --windows --window $YABAI_WINDOW_ID)

title=$(echo $data | jq .title)
display=$(echo $data | jq .display)

if [[ $title =~ "capture-popup" && $display == 1 ]]; then
yabai -m window $YABAI_WINDOW_ID --toggle float --move abs:530:230
yabai -m window $YABAI_WINDOW_ID --resize abs:655:300
yabai -m window $YABAI_WINDOW_ID --focus
elif
[[ $title =~ "minimal-popup" && $display == 1 ]]; then
yabai -m window $YABAI_WINDOW_ID --toggle float --move abs:530:230
yabai -m window $YABAI_WINDOW_ID --resize abs:655:200
yabai -m window $YABAI_WINDOW_ID --focus
elif
[[ $title =~ "large-popup" && $display == 1 ]]; then
yabai -m window $YABAI_WINDOW_ID --toggle float --move abs:450:130
yabai -m window $YABAI_WINDOW_ID --resize abs:830:700
yabai -m window $YABAI_WINDOW_ID --focus    
else
false
fi
