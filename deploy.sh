#!/usr/bin/sh

files=$(ls -a1| egrep -v '^.$|^..$|README.md|.gitignore|.git|deploy.sh|.directory|.ssh|shell')
target=~

link(){
    ln -sf "$PWD/$1" "$2"
}

for f in $files; do
    link "$f" "$target/$f"
done

ln -sf .ssh/config ~/.ssh
chmod 600 ~/.ssh/config
