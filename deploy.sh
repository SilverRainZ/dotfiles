#!/usr/bin/sh

files=$(ls -a1| egrep -v '^.$|^..$|README.md|.gitignore|.git|deploy.sh|.directory')
target=~

link(){
    ln -sf "$PWD/$1" "$2"
}

for f in $files; do
    echo $f
    link "$f" "$target/$f"
done
