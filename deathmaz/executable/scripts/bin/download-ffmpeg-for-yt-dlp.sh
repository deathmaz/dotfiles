#!/bin/bash

# see https://github.com/yt-dlp/FFmpeg-Builds

cd /tmp
curl -L https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz -O
tar -xf ffmpeg-master-latest-linux64-gpl.tar.xz
mkdir -p $HOME/ffmpeg-for-yt-dlp
cp -f /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg $HOME/ffmpeg-for-yt-dlp/ffmpeg
rm -rf ffmpeg-master-latest-linux64-gpl*
