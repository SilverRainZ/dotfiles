#!/bin/bash

cd "$(dirname "$0")"

LN_OPTS="-sf"
[ "$1" = "-v" ] && LN_OPTS="$LN_OPTS -v"

relink(){
    name=$(basename "$1")
    mkdir -p "$2"
    unlink "$2/$name" 2>/dev/null || true
    ln $LN_OPTS "$PWD/$1" "$2"
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

echo Installing user bin...
for f in bin/*; do
    relink "$f" ~/bin
done

echo Installing Codex configuration...
relink agents/AGENTS.md ~/.codex

echo Installing skills for general agents...
for dir in agents/skills/*/; do
    [ -d "$dir" ] || continue
    relink "$dir" ~/.agents/skills
done

echo Installing skills for ClaudeCode...
for dir in agents/skills/*/; do
    [ -d "$dir" ] || continue
    relink "$dir" ~/.claude/skills
done

echo Installing Agents for general agents...
for dir in agents/agents/*; do
    relink "$dir" ~/.agents/agents
done
