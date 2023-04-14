#!/bin/bash

if pgrep -x "kitty" > /dev/null
then
  wmctrl -xa "kitty"
else
  /usr/bin/kitty
fi
