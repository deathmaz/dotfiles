#!/bin/bash

if pgrep -x "telegrap" > /dev/null
then
  wmctrl -xa "telegram"
else
  /usr/bin/telegram-desktop
fi
