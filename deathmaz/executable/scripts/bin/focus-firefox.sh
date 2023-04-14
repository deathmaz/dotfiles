#!/bin/bash

if pgrep -x "firefox" > /dev/null
then
    wmctrl -xa "firefox"
else
    /usr/bin/firefox
fi
