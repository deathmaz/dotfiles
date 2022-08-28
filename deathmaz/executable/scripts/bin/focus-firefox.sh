#!/bin/bash

wmctrl -i -a $(wmctrl -l | grep Firefox | tail -1)
