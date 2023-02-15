#!/bin/bash

read_w3m() {
    /usr/bin/readable "$1" -p html-title,html-content > /tmp/readable.html \
    && /usr/bin/kitty @ launch --type=tab /usr/bin/w3m /tmp/readable.html \
    && /usr/bin/kitty @ launch \
    && /usr/bin/kitty @ focus-window --match 'title:^w3m'
    # && /usr/bin/kitty @ set-colors --all $HOME/dotfiles/deathmaz/kitty/.config/kitty/themes/gruvbox-light.conf
}

content=$(xclip -selection clipboard -o)

read_w3m "$content"
