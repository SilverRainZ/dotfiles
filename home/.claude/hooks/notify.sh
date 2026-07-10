#!/bin/bash
# Notification hook: show which session/project the notification is from

ICON="$HOME/pictures/icons/claude.svg"

input=$(cat)
cwd=$(jq -r '.cwd // "unknown"' <<<"$input")
type=$(jq -r '.notification_type // ""' <<<"$input")
msg=$(jq -r '.message // ""' <<<"$input")
transcript=$(jq -r '.transcript_path // ""' <<<"$input")
project=$(basename "$cwd")

# Prefix with [tmux:window@session] when running inside tmux
title="${project}: ${type}"
if [ -n "$TMUX" ] && [ -n "$TMUX_PANE" ]; then
    ws=$(tmux display-message -t "$TMUX_PANE" -p '#W@#S' 2>/dev/null)
    [ -n "$ws" ] && title="[tmux:${ws}] ${title}"
fi

# Append Claude's last assistant text for context
if [ -f "$transcript" ]; then
    last=$(tac "$transcript" | while IFS= read -r line; do
        t=$(jq -r 'select(.type=="assistant") | (.message.content[]? | select(.type=="text") | .text) // empty' <<<"$line" 2>/dev/null)
        [ -n "$t" ] && { printf '%s' "$t"; break; }
    done)
    if [ -n "$last" ]; then
        # Truncate to keep the notification readable
        last=$(printf '%s' "$last" | head -c 300)
        msg="${msg:+$msg

}${last}"
    fi
fi

notify-send -a "Claude Code" -i "$ICON" "${title}" "${msg}"
