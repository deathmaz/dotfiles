#!/bin/bash

if pgrep -x "kitty" > /dev/null
then
  wmctrl -xa "kitty"
else
  /home/maz/.local/kitty.app/bin/kitty
fi
