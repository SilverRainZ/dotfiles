#!/bin/sh

link(){
    ln -sfv "$PWD/$1" "$2"
}

# Link home
files=$(ls -A1 | egrep -v 'README.rst|deploy.sh|.gitignore|.git$|.config|Makefile|conf.py|index.rst')
target=~
for f in $files; do
    unlink "$target" || true
    link "$f" "$target"
done

# Link xdg config home
files=$(ls -A1 .config)
target=~/.config
mkdir -p $target || true
for f in $files; do
    unlink "$target/$f" || true
    link ".config/$f" "$target/$f"
done
