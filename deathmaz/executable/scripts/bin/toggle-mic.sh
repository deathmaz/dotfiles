#!/bin/bash

state=$(amixer get Capture | grep -o "\[on\]" | head -1)

if [[ $state == "[on]" ]]; then
    # Microphone is unmuted, so mute it
    amixer set Capture nocap
else
    # Microphone is muted, so unmute it
    amixer set Capture cap
fi
