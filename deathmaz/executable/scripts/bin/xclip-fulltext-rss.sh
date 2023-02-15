#!/bin/bash

read_fulltext() {
    result=$(curl "http://127.0.0.1:8877/extract.php?url=$1" | jq -r '.content')
    html="<!DOCTYPE html>
    <html lang=\"en\">
    <head>
    <meta charset=\"UTF-8\">
    <style>
      img {
        max-width: 100%;
        height: auto;
      }
      body { padding: 32px; font-family: \"OpenSans\", \"Cantarell\", \"Helvetica\", \"Arial\", \"PingFang SC\", \"Microsoft YaHei\", sans-serif; font-size: 20px; line-height: 1.5; }
      .content-wrapper {
        max-width: 800px;
        width: 100%;
        margin: auto;
      }
    </style>
    </head><body>
    <div class=\"content-wrapper\">
      $result
    </div></body></html>"
    echo $html > /tmp/fulltext.html && /usr/bin/brave /tmp/fulltext.html
}

content=$(xclip -selection clipboard -o)

read_fulltext "$content"
