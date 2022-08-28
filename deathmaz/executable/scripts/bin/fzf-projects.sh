#!/bin/bash

cd $( ls -d ~/projects/*/ | fzf ) && /home/maz/execs/neovim/bin/nvim $(fzf)
