#!/bin/bash

yt-dlp --skip-download --flat-playlist --print "%()j" $1 \
  | jq -r \
  '"#EXTINF:" + (.duration | tostring) + "," + .channel + " - " + .title + "\n" + .url' > res.m3u
