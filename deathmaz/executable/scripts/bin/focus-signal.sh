#!/bin/bash

if pgrep -x "signal-desktop" > /dev/null
then
  wmctrl -xa "signal"
else
  /usr/bin/signal-desktop
fi
