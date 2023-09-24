#!/bin/bash

# yt-dlp --skip-download --flat-playlist --print "%()j" "$1" \
#   | jq -r 'reverse | .[] |
#   if .duration == null then
#     "#EXTINF:0," + .channel + " - " + .title + "\n" + .url
#   else
#     "#EXTINF:" + (.duration / 60 | floor | tostring) + "," + .channel + " - " + .title + "\n" + .url
#   end
#   ' > res.m3u

tmp_file=$(mktemp)

yt-dlp --skip-download --flat-playlist --print "%()j" "$1" > "$tmp_file"

tac "$tmp_file" | jq -r '
  if .duration == null then
    "#EXTINF:0," + .channel + " - " + .title + "\n" + .url
  else
    "#EXTINF:" + (.duration / 60 | round | tostring) + "," + .channel + " - " + .title + "\n" + .url
  end
' > res.m3u

rm "$tmp_file"
