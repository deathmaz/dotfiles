#!/bin/bash

wmctrl -i -a $(wmctrl -l | grep mpv | tail -1)
