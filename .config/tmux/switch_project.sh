#!/bin/zsh

currSessions=$(tmux list-sessions -F "#{session_id} #S" | sort | cut -d ' ' -f 2)
fd=fd
[ -f /usr/bin/fdfind ] && fd=fdfind
currProjects=$($fd -d 4 --hidden --no-ignore -t d '.git$' ~/git/ | awk -F '/.git' '{print $1}' | awk -F "${HOME}/git/" '{print $2}' | cut -d ' ' -f 1)
uniqProjects=$(echo "${currSessions}\n${currProjects}" | sort | uniq -u)
highlightSession=$(echo "$currSessions" | awk '{ printf ("%s *\n", $1) }')
selectProjects=($(echo "${highlightSession}\n${uniqProjects}" | awk '{printf ("%3d\t%s\t%s\n", NR, $1, $2) }' | fzf-tmux -p --color=hl:2 | cut -f 2))

if [ "$selectProjects" ] ; then
  for curProject in "${selectProjects[@]}"
  do
    tmuxinator start project $HOME/git/$curProject
  done
fi
