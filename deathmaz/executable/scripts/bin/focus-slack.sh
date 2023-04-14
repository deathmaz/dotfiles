#!/bin/bash

if pgrep -x "slack" > /dev/null
then
  wmctrl -xa "slack"
else
  /usr/bin/slack
fi
