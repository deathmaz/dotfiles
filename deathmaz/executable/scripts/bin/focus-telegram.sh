#!/bin/bash

wmctrl -i -a $(wmctrl -l | grep Telegram | tail -1)
