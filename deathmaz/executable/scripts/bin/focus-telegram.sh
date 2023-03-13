#!/bin/bash

line=$(ps -aux | grep telegram | head -1)
words=($line)
window=$( wmctrl -lp | grep ${words[1]} )

wmctrl -i -a $window
