#!/bin/bash

content=$(xclip -selection clipboard -o)
notify-send -i gnome-mpv -t 5000 "Starting video:" "$content"
$MAZ_SCRIPTS_BIN/mpv-custom "$content"
