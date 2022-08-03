Bash
====

:date: 2015-7-21

.bashrc
=======

.. litfile:: ~/.bashrc

Load counter::

   export LA_BASHRC_LOADED=$(($LA_BASHRC_LOADED+1))

::

   case "$TERM" in
       xterm)
           export TERM=xterm-256color
           ;;
       screen)
           export TERM=screen-256color
           ;;
   esac

Include aliases::

   source $HOME/.alias

Terminal
========

TTY
---

:require:`platform:linux`::

   if [ "$TERM" = "linux" ]; then
       source .tty
   fi

iterm2
------

:require:`exec:iterm`::

   if [[ "$ITERM_SESSION_ID" ]]; then
       source "${HOME}/.iterm2_shell_integration.zsh"
   fi


tilix
-----

:require:`exec:tilix`:

Fix tilix VTE configuration Issue::

   if [[ $TILIX_ID ]]; then
       source /etc/profile.d/vte.sh
   fi

Ref: https://github.com/gnunn1/tilix/wiki/VTE-Configuration-Issue

Plugins
=======

sphinxnotes-snippet
-------------------

:require:`exec:snippet`::

   eval "$(snippet integration --sh --sh-binding)"

autojump
--------

:require:`exec:autojump`

.. code::
   :only: linux

   source /etc/profile.d/autojump.sh

.. code::
   :only: macOS

    source /usr/local/etc/profile.d/autojump.sh
