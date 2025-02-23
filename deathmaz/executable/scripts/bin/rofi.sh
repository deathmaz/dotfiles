#!/bin/bash

rofi -combi-modi "window,nova:$MAZ_SCRIPTS_BIN/rofi-nova-script,drun,run" \
  -modes "window,nova:$MAZ_SCRIPTS_BIN/rofi-nova-script,drun,run" \
  -show combi
