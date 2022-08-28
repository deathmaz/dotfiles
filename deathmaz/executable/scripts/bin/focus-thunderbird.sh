#!/bin/bash

wmctrl -i -a $(wmctrl -l | grep 'Mozilla Thunderbird')
