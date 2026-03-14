#!/bin/bash

# set -x

cd "$(dirname "$0")" && pwd

link(){
    ln -sfv "$PWD/$1" "$2"
}

nolink(){
    unlink "$1" 2>/dev/null || true
}

mkdir -p ~/.config/opencode
mkdir -p ~/.codex
mkdir -p ~/.agents/skills

nolink ~/.config/opencode/AGENTS.md
link AGENTS.md $_

nolink ~/.codex/AGENTS.md
link AGENTS.md $_

for dir in "skills"/*/; do
    name=$(basename "$dir")
    nolink "~/.agents/skills/$name"
    link "$dir" ~/.agents/skills
done
