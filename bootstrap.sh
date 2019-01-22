#!/bin/sh -eux

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s $HOME/DotFiles/vimrc ~/.vimrc
ln -s $HOME/DotFiles/gitconfig ~/.gitconfig
vim +PlugInstall

fish < ./abbr.fish
