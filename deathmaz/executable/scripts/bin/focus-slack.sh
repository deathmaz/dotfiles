#!/bin/bash

wmctrl -i -a $(wmctrl -l | grep Slack)
