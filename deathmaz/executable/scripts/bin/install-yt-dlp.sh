#!/bin/bash

mkdir -p $HOME/.local/bin
cd $HOME/.local/bin
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o yt-dlp
chmod +x yt-dlp
