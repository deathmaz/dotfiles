#!/bin/bash

window=$(wmctrl -l | grep Firefox | tail -1)

if [[ -z "$window" ]]; then
  /usr/bin/firefox
else
  wmctrl -i -a $window
fi
