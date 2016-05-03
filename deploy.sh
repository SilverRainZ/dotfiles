#!/usr/bin/sh

files=$(ls -a1| egrep -v '^.$|^..$|README.md|.gitignore|.git|deploy.sh|.directory|.ssh|shell')
target=~

link(){
    ln -sfv "$PWD/$1" "$2"
}

for f in $files; do
    link "$f" "$target"
done

mkdir $target/.ssh || true
ln -sf $PWD/.ssh/config $target/.ssh/config
chmod 600 ~/.ssh/config
