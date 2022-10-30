#!/bin/sh

## setup
cd ~/

## install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile

## make project file

mkdir ~/Projects

## install chrome 
brew install google-chrome

## install Japanese
brew install google-japanese-ime

## install vscode
brew install visual-studio-code --cask


## install jetbrains toolbox
brew install jetbrains-toolbox


## install Alfred
brew install alfred

## install xbar
brew install xbar
  

## install fork
brew install fork


## install zoom
brew install zoom

## install discord
brew install discord


## install line

brew install mas
 mas install 539883307 # LINE


## install slack
brew install slack


## install git

brew install git
brew install git-lfs
git lfs install

## install tmux
brew install tmux


## python env
brew install pyenv-virtualenv
brew install pyenv-virtualenvwrapper
brew install pyenv

## install java env with graalvm
## see https://www.graalvm.org/22.1/docs/getting-started/macos/


cd ~/dotfiles

chmod 755 ./set_dotfiles.sh
./set_dotfiles.sh

source ~/.zshrc
source ~/.vimrc
source ~/.gvimrc


## set ssh config
ssh-keygen -t ed25519 -C "me@mizune.ms"


