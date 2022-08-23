Bash
====

# date: 2015-7-21

``~.bashrc``
============

.. litconf:: ~/.bashrc

Shell source counter::

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

Aliases::

   source $HOME/.alias

Terminal
--------

tilix::

   if [[ $TILIX_ID ]]; then
       # Fix tilix VTE configuration Issue
       # Ref: https://github.com/gnunn1/tilix/wiki/VTE-Configuration-Issue
       source /etc/profile.d/vte.sh
   fi

TTY::

   if [ "$TERM" = "linux" ]; then
       source .tty
   fi

iterm2::

   if [[ "$ITERM_SESSION_ID" ]]; then
       source "${HOME}/.iterm2_shell_integration.zsh"
   fi

Plugins
-------

:requires:`pip|sphinxnotes-snippet`::

   eval "$(snippet integration --sh --sh-binding)"

autojump::

.. code::
   :requires: os|linux|arch pacman/autojump

    source /etc/profile.d/autojump.sh

.. code::
   :requires: os|macos brew|autojump

    source /usr/local/etc/profile.d/autojump.sh


``~/.bash_profile``
===================

::

   export LA_BASH_PROFILE_LOADED=$(($LA_BASH_PROFILE_LOADED+1))

   [[ -f ~/.profile ]] && . ~/.profile
   [[ -f ~/.bashrc ]] && . ~/.bashrc
