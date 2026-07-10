#!/bin/bash
# Notification hook: show which session/project the notification is from

ICON="$HOME/pictures/icons/claude.svg"

input=$(cat)
cwd=$(jq -r '.cwd // "unknown"' <<<"$input")
type=$(jq -r '.notification_type // ""' <<<"$input")
msg=$(jq -r '.message // ""' <<<"$input")
project=$(basename "$cwd")

notify-send -a "Claude Code" -i "$ICON" "${project}: ${type}" "${msg}"
