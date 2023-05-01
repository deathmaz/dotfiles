#!/bin/bash

content=$(xclip -selection clipboard -o)
notify-send -i gnome-mpv -t 5000 "Starting video:" "$content"
/home/maz/dotfiles/deathmaz/executable/scripts/bin/mpv-custom "$content" &> /tmp/xclip-to-mpv
