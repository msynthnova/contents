#!/bin/sh

cp ./.tmux.conf ~/ && cat ./.zshrc >> ~/.zshrc && cp ./kitty.conf ~/.config/kitty/kitty.conf && cp ./init.lua ~/.config/nvim/init.lua
