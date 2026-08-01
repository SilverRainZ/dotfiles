#!/bin/bash

cd "$(dirname "$0")"

link(){
    ln -sfv "$PWD/$1" "$2"
}

nolink(){
    unlink "$1" 2>/dev/null || true
}
relink(){
    name=$(basename "$1")
    mkdir -p "$2"
    unlink "$2/$name" 2>/dev/null || true
    ln -sfv "$PWD/$1" "$2"
}

echo Installing home dotfiles...
for f in home/.*; do
    [ "$f" = "home/." ] || [ "$f" = "home/.." ] && continue
    relink "$f" ~
done

echo Installing XDG config...
for f in config/*; do
    relink "$f" ~/.config
done

echo Installing Codex configuration...
relink agents/AGENTS.md ~/.codex

echo Installing skills for general agents...
for dir in agents/skills/*/; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    nolink ~/.agents/skills/$name
    link "$dir" ~/.agents/skills
done

echo Installing skills for ClaudeCode...
for dir in agents/skills/*/; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    nolink ~/.claude/skills/$name
    link "$dir" ~/.claude/skills
done

echo Installing Agents for general agents...
mkdir -p ~/.agents/agents
for dir in agents/agents/*; do
    name=$(basename "$dir")
    nolink ~/.agents/agents/$name
    link "$dir" ~/.agents/agents
done
