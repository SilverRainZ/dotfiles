#!/usr/bin/sh

files=$(ls -A1 | egrep -v 'README.md|.gitignore|.git|deploy.sh')
target=~

link(){
    ln -sfv "$PWD/$1" "$2"
}

for f in $files; do
    link "$f" "$target"
done
