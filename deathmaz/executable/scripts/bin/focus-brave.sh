#!/bin/bash

if pgrep -x "brave" > /dev/null
then
    wmctrl -xa "brave"
else
    /usr/bin/brave
fi
