#!/bin/bash

read_fulltext() {
    result=$(curl "http://127.0.0.1:8877/extract.php?url=$1" | jq -r '.content')
    html="<!DOCTYPE html>
    <html lang=\"en\">
    <head>
    <meta charset=\"UTF-8\">
    <style>
      :root {
        --text-color: #000;
        --bg-color: #fff;
        --link-color: #539bf5;
      }

      @media (prefers-color-scheme: dark) {
        :root {
          --text-color: #adbac7;
          --bg-color: #22272e;
        }
      }

      img {
        max-width: 100%;
        height: auto;
      }
      body {
        padding: 32px;
        font-family: \"OpenSans\", \"Cantarell\", \"Helvetica\", \"Arial\", \"PingFang SC\", \"Microsoft YaHei\", sans-serif;
        font-size: 25px;
        line-height: 1.5;
        color: var(--text-color);
        background-color: var(--bg-color);
      }
      a {
        color: var(--link-color);
      }
      .content-wrapper {
        max-width: 800px;
        width: 100%;
        margin: auto;
      }
    </style>
    </head><body>
    <div class=\"content-wrapper\">
      <div>
      <a href=\"$1\" target=\"_blank\" rel=\"noopener noreferrer\">
        $1
      </a>
      </div>
      <br>
      <br>
      $result
    </div></body></html>"
    last_part=$(basename "$1")
    mkdir -p ~/Downloads/articles
    destination="${HOME}/Downloads/articles/${last_part}.html"
    echo $html > "$destination"
    kitten @ --to unix:/tmp/mykitty launch --tab-title=article --cwd=~/Downloads/articles --type=tab \
      $MAZ_CLI_BROWSER "$destination" && $MAZ_SCRIPTS_BIN/focus-st
    # kitten @ --to unix:/tmp/mykitty launch --tab-title=article --cwd=~/Downloads/articles --type=tab $MAZ_CLI_BROWSER "$destination" && $MAZ_SCRIPTS_BIN/focus-st
    # tmux new-window
    # tmux split-window -h
    # tmux select-pane -t 1
    # tmux resize-pane -x 80
    # tmux send-keys "$MAZ_CLI_BROWSER "$destination"" 'Enter'
    # $MAZ_SCRIPTS_BIN/focus-st
}
