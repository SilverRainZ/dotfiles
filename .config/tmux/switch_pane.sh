#!/bin/bash

TARGET_SPEC="#{session_id}-#{window_index}:#{pane_index}:::#{session_name}:::#{window_id}:::#{pane_id}:::"

# customizable
LIST_DATA="#{session_name} #{window_index}:#{pane_index} | #{window_name} | #{pane_title} | #{pane_current_path} | #{pane_current_command}"
FZF_COMMAND="fzf-tmux -p --delimiter=::: --with-nth 5 --color=hl:2 --tiebreak=index"


# select pane
LINE=$(tmux list-panes -a -F "$TARGET_SPEC $LIST_DATA" | sort | $FZF_COMMAND) || exit 0
# split the result
args=(${LINE//:::/ })
# activate session/window/pane
tmux select-pane -t ${args[3]} && tmux select-window -t ${args[2]} && tmux switch-client -t ${args[1]}
