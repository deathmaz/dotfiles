#!/bin/bash

read_fulltext() {
    result=$(curl "http://127.0.0.1:8877/extract.php?url=$1" | jq -r '.content')
    html="<!DOCTYPE html>
    <html lang=\"en\">
    <head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />
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
        padding: 0.75rem;
        font-family: \"OpenSans\", \"Cantarell\", \"Helvetica\", \"Arial\", \"PingFang SC\", \"Microsoft YaHei\", sans-serif;
        font-size: 1.3rem;
        line-height: 1.5;
        color: var(--text-color);
        background-color: var(--bg-color);
      }

      @media (min-width: 48rem) {
        body {
          padding: 2rem;
          font-size: 1.5625rem;
        }
      }

      a {
        color: var(--link-color);
      }
      .content-wrapper {
        max-width: 50rem;
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
    network_share="$HOME/rpi/articles"
    if [ -d "$network_share" ]; then
      download_dir="$network_share"
    else
      download_dir="${HOME}/Downloads/articles"
    fi
    mkdir -p "$download_dir"
    destination="$download_dir/${last_part}.html"
    echo $html > "$destination"
    kitten @ --to unix:/tmp/mykitty launch --tab-title=article --cwd="$download_dir" --type=tab \
      $MAZ_CLI_BROWSER "$destination" && $MAZ_SCRIPTS_BIN/focus-st
    # kitten @ --to unix:/tmp/mykitty launch --tab-title=article --cwd=~/Downloads/articles --type=tab $MAZ_CLI_BROWSER "$destination" && $MAZ_SCRIPTS_BIN/focus-st
    # tmux new-window
    # tmux split-window -h
    # tmux select-pane -t 1
    # tmux resize-pane -x 80
    # tmux send-keys "$MAZ_CLI_BROWSER "$destination"" 'Enter'
    # $MAZ_SCRIPTS_BIN/focus-st
}
