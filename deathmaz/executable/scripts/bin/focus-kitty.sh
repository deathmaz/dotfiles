#!/bin/bash

if pgrep -x "kitty" > /dev/null
then
  wmctrl -xa "kitty"
else
  $HOME/.local/kitty.app/bin/kitty
fi
