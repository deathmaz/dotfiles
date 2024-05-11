#!/bin/bash

set -e

sudo pacman -S \
  fd \
  jq \
  yay \
  pass \
  playerctl\
  mpv-mpris \
  lynx \
  go \
  zsh \
  redshift \
  docker \
  feh \
  bat \
  newsboat \
  npm \
  pacman-contrib \
  ripgrep \
  stow \
  tmux \
  vifm \
  noto-fonts-emoji \
  mpv \
  w3m \
  yarn \
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
  sxhkd \
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
  manjaro-settings-samba \
  python-secretstorage \
  thunar-shares-plugin \
  thefuck \
  git-delta \
  telegram-desktop \
  github-cli \
  veracrypt \
  mpd \
  zoxide \
  ncmpcpp \
  mpc \
  tree-sitter \
  jdk-openjdk \
  libxcrypt-compat \
  --noconfirm \
  --needed

# keymapper \
yay -S \
  nodejs-readability-cli \
  nodejs-markdown-toc \
  mouseless-bin \
  tuir \
  mpd-mpris-bin \
  viddy \
  urlview \
  easystroke \
  docker-credential-pass-bin \
  birdtray \
  slack-desktop \
  watchman-bin \
  viber \
  task-spooler \
  protonmail-bridge-bin \
  aur/teams \
  gofumpt \
  golines \
  vscode-codicons-git \
  android-studio \
  indicator-sound-switcher \
  --noconfirm \
  --needed

# systemctl enable keymapperd
# systemctl start keymapperd

source $HOME/dotfiles/deathmaz/executable/scripts/bin/update-manually-installed.sh

go install golang.org/x/tools/cmd/goimports@latest
go install github.com/deathmaz/go-replace-youtube@latest
go install github.com/x-motemen/ghq@latest

# https://unix.stackexchange.com/a/343582
# should be started after mpd config was created
systemctl --user start mpd.service
systemctl --user enable mpd.service

systemctl --user enable mpd-mpris.service
systemctl --user start mpd-mpris.service

rustup install stable
rustup default stable

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $USER

sudo systemctl enable paccache.timer
sudo systemctl start paccache.timer

git submodule update --init --recursive

echo 'export EDITOR="$HOME/execs/neovim/bin/nvim"
export BROWSER="/usr/bin/brave"
export VISUAL="$HOME/execs/neovim/bin/nvim"
export HOMEBREW_BUNDLE_NO_LOCK="1"
export MAZ_SCRIPTS_BIN="$HOME/dotfiles/deathmaz/executable/scripts/bin"
export MAZ_CLI_BROWSER="w3m"
export FZF_DEFAULT_OPTS="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6,marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 --reverse"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob \!.git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--bind ctrl-j:preview-down,ctrl-l:preview-up --preview '\''(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'\''"' \
  | sudo tee -a /etc/profile
