#!/bin/bash

set -e

sudo pacman -S \
  jq \
  yay \
  pass \
  lynx \
  go \
  zsh \
  redshift \
  docker \
  feh \
  bat \
  newsboat \
  npm \
  ripgrep \
  stow \
  tmux \
  vifm \
  noto-fonts-emoji \
  mpv \
  w3m \
  yarn \
  youtube-dl \
  ncdu \
  discord \
  ttf-sourcecodepro-nerd \
  calibre \
  rustup \
  aria2 \
  wine \
  xorg-xbacklight \
  btop \
  base-devel \
  elinks \
  rofi \
  xclip \
  fzf \
  flameshot \
  wmctrl \
  zsh-theme-powerlevel10k \
  xorg-xwininfo \
  brave-browser \
  docker-compose \
  the_silver_searcher \
  surfraw \
  streamlink \
  xdotool \
  wmctrl \
  python-pynvim \
  signal-desktop \
  thefuck \
  git-delta \
  telegram-desktop \
  github-cli \
  veracrypt \
  mpd \
  ncmpcpp \
  mpc \
  tree-sitter \
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
  nodejs-readability-cli \
  keymapper \
  tuir \
  viddy \
  urlview \
  autojump \
  docker-credential-pass-bin \
  birdtray \
  slack-desktop \
  watchman-bin \
  viber \
  task-spooler \
  protonmail-bridge-bin \
  aur/teams \
  gofumpt \
  vscode-codicons-git \
  indicator-sound-switcher \
  --noconfirm \
  --needed

systemctl enable keymapperd
systemctl start keymapperd

npm install -g eslint eslint-plugin-vue prettier prettier-eslint
