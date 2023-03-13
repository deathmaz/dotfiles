#!/bin/bash

window=$(wmctrl -l | grep Slack)

if [[ -z "$window" ]]; then
  /usr/bin/slack
else
  wmctrl -i -a $window
fi
