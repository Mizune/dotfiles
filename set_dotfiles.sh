#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Hammerspoon
mkdir -p ~/.hammerspoon
ln -sf ~/dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

# Ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config

# Starship
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
