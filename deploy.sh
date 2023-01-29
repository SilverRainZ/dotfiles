#!/bin/sh

files=$(ls -A1 | egrep -v 'README.md|deploy.sh|.gitignore|.git$|.config')
target=~

link(){
    ln -sfv "$PWD/$1" "$2"
}

# Link home
files=$(ls -A1 | egrep -v 'README.rst|deploy.sh|.gitignore|.git$|.config|Makefile|conf.py|index.rst')
target=~
for f in $files; do
    link "$f" "$target"
done

# Link xdg config home
files=$(ls -A1 .config)
target=~/.config
for f in $files; do
    link ".config/$f" "$target"
done
