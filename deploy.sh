#!/bin/sh

link(){
    ln -sfv "$PWD/$1" "$2"
}

# Link home
files=$(ls -A1 | grep -Ev 'README.rst|deploy.sh|\.gitignore|\.git$|\.config|Makefile|archpkgs.txt')
target=~
for f in $files; do
    unlink $target/$f 2>/dev/null || true
    link $f $target
done

# Link XDG config home.
files=$(ls -A1 $PWD/.config)
target=~/.config
mkdir -p $target 2>/dev/null || true
for f in $files; do
    unlink $target/$f 2>/dev/null || true
    link .config/$f $target/$f
done

# Link SystemD user config
files=$(ls -A1 $PWD/.config/systemd/user/)
target=~/.config/systemd/user/
mkdir -p $target 2>/dev/null || true
for f in $files; do
    unlink $target/$f 2>/dev/null || true
    link .config/systemd/user/$f $target/$f
done
