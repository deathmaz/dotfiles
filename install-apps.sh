#!/bin/bash

sudo pacman -S \
  yay \
  pass \
  go \
  zsh \
  redshift \
  docker \
  birdcount \
  kitty \
  feh \
  bat \
  newsboat \
  node \
  npm \
  ripgrep \
  stow \
  tmux \
  vifm \
  w3m \
  yarn \
  youtube-dl \
  ncdu \
  discord \
  calibre \
  rustup \
  aria2 \
  wine \
  xorg-xbacklight \
  bpytop \
  base-devel \
  elinks \
  rofi \
  xclip \
  fzf \
  flameshot \
  wmctrl \
  brave-browser \
  docker-compose \
  the_silver_searcher \
  surfraw \
  streamlink \
  xdotool \
  wmctrl \
  yt-dlp \
  python-pynvim \
  thefuck \
  git-delta \
  telegram-desktop \
  github-cli \
  veracrypt \
  mpd \
  ncmpcpp \
  mpc \
  tree-sitter \
  simplescreenrecorder \
  # see https://stackoverflow.com/a/71189742, comment
  libxcrypt-compat \
  --noconfirm \
  --needed

rustup install stable
rustup default stable

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $USER

# https://unix.stackexchange.com/a/343582
systemctl --user start mpd.service
systemctl --user enable mpd.service

# github-cli extensions
gh extension install dlvhdr/gh-dash
gh extension install seachicken/gh-poi

yay -S \
  tuir \
  viddy \
  urlview \
  zsh-theme-powerlevel10k-git \
  autojump \
  docker-credential-pass-bin \
  birdtray \
  slack-desktop \
  watchman-bin \
  viber \
  task-spooler \
  protonmail-bridge-bin \
  aur/teams \
  nerd-fonts-source-code-pro \
  gofumpt \
  vscode-codicons-git \
  indicator-sound-switcher \
  --noconfirm \
  --needed

npm install -g readability-cli eslint eslint-plugin-vue prettier prettier-eslint
