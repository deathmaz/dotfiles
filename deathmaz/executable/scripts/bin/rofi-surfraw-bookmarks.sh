#!/bin/bash

surfraw -browser=xdg-open "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | \
    sed '/^#/d' | sed '/^\//d' | sort -n | rofi \
    -dmenu -mesg ">>> Edit to add new bookmarks at ~/.config/surfraw/bookmarks"\
    -i -p "bookmarks: ")"
