#!/usr/bin/sh

files=$(ls -a1| egrep -v '^.$|^..$|README.md|.gitignore|.git|deploy.sh|.directory|.ssh')
target=~

link(){
    ln -sf "$PWD/$1" "$2"
}

for f in $files; do
    link "$f" "$target/$f"
done

git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ln -sf .ssh/config ~/.ssh
chmod 600 ~/.ssh/config

