#!/bin/bash

cd $HOME/dotfiles/deathmaz/zsh/.zsh/plugins
rm -rf fast-syntax-highlighting
git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting
