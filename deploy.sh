#!/bin/bash

cd "$(dirname "$0")"

link(){
    ln -sfv "$PWD/$1" "$2"
}

nolink(){
    unlink "$1" 2>/dev/null || true
}

echo Installing home dotfiles...
for f in home/.*; do
    [ "$f" = "home/." ] || [ "$f" = "home/.." ] && continue
    name=$(basename "$f")
    nolink ~/$name
    link "$f" ~/
done

echo Installing XDG config...
mkdir -p ~/.config
for f in config/*; do
    name=$(basename "$f")
    nolink ~/.config/$name
    link "$f" ~/.config
done

echo Installing Codex configuration...
mkdir -p ~/.codex
nolink ~/.codex/AGENTS.md
link agents/AGENTS.md ~/.codex

echo Installing Codex configuration...
mkdir -p ~/.codex
nolink ~/.codex/AGENTS.md
link agents/AGENTS.md ~/.codex

echo Installing General Agent Skills...
mkdir -p ~/.agents/skills
for dir in agents/skills/*/; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    nolink ~/.agents/skills/$name
    link "$dir" ~/.agents/skills
done

echo Installing General Agents...
mkdir -p ~/.agents/agents
for dir in agents/agents/*; do
    name=$(basename "$dir")
    nolink ~/.agents/agents/$name
    link "$dir" ~/.agents/agents
done
