#!/bin/bash

source $HOME/dotfiles/deathmaz/executable/scripts/bin/fulltext-rss.sh

content=$(xclip -selection clipboard -o)

read_fulltext "$content"
