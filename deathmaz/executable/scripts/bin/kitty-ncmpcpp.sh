#!/bin/bash

line=$(ps -aux | grep 'ncmpcpp$' | grep 'kitty')
if [[ -z "$line" ]]; then
  /home/maz/.local/kitty.app/bin/kitty /usr/bin/ncmpcpp
else
  words=($line)
  window=$( wmctrl -lp | grep ${words[1]} )

  wmctrl -i -a $window
fi
