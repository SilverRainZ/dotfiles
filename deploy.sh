#!/bin/bash

# set -x

cd "$(dirname "$0")"

link(){
    ln -sfv "$PWD/$1" "$2"
}

nolink(){
    unlink "$1" 2>/dev/null || true
}

echo Installing OpenCode configuration...
nolink ~/.config/opencode
link opencode $_

echo Installing Codex configuration...
mkdir -p ~/.codex
nolink ~/.codex/AGENTS.md
link AGENTS.md $_

echo Installing Skills...
mkdir -p ~/.agents/skills
for dir in "skills"/*/; do
    name=$(basename "$dir")
    nolink "~/.agents/skills/$name"
    link "$dir" ~/.agents/skills
done
