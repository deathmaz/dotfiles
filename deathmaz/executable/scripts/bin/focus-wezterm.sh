#!/bin/bash

if pgrep -x "wezterm" > /dev/null
then
    wmctrl -xa "wezterm"
else
  /home/maz/.local/bin/wezterm
fi
