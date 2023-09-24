#!/bin/bash

[ -f $HOME/.env ] && export $(envsubst < $HOME/.env)
content=$(xclip -selection clipboard -o)

$HOME/gosrc/bin/go-replace-youtube "$content" &> /tmp/go-replace-youtube
