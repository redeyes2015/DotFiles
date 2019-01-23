#!/bin/sh -eux

InstallDir=$HOME/DotFiles

curl -sSLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s $InstallDir/vimrc ~/.vimrc
ln -s $InstallDir/gitconfig ~/.gitconfig
tmpvimrc=$(mktemp)
sed -n '1,/plug\#end/p' ~/.vimrc > "$tmpvimrc"
vim -u "$tmpvimrc" +PlugInstall +qa
rm "$tmpvimrc"

mkdir -p ~/.config/fish
ln -s $InstallDir/config.fish ~/.config/fish/config.fish
fish < $InstallDir/abbr.fish
curl -sSLo ~/.config/fish/functions/fisher.fish --create-dirs \
    https://raw.githubusercontent.com/jorgebucaran/fisher/master/fisher.fish
ln -s $InstallDir/fishfile ~/.config/fish/fishfile
fish -c fisher
ln -s $InstallDir/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install --no-zsh --no-bash

git clone --depth 1 https://github.com/so-fancy/diff-so-fancy $InstallDir/diff-so-fancy.repo

git clone --depth 1 https://github.com/creationix/nvm.git ~/.nvm

