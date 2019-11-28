#!/bin/sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install zsh vim tmux
brew cask install alacritty

sudo echo "/usr/local/bin/zsh" >> "/etc/shells"

sudo chsh -s /usr/local/bin/zsh

chmod 755 ./set_dotfiles.sh
./set_dotfiles.sh

source ~/.zshrc
source ~/.vimrc
source ~/.gvimrc

