========
dotfiles
========

Dotfiles — then tools and prompts joined.

I use...
========

Softwares
---------

======================= ========================================================
Distribution            Arch Linux (for life) and macOS (for work)
Desktop environment     *N/A*
Window manager          Sway_
Web browser             Firefox
Shell                   Zsh_
Terminal                kitty_ and Alacritty_
Terminal multiplexer    tmux_
Editor                  Neovim_
IRC client              Srain_
Coding Agent            OpenCode_ and Codex
AI Assistant            Hermes
======================= ========================================================

.. _Sway: config/sway/
.. _Zsh: home/.zshrc
.. _tmux: config/tmux/
.. _Neovim: config/nvim/
.. _Srain: config/srain/
.. _Alacritty: config/alacritty/
.. _kitty: config/kitty/
.. _OpenCode: config/opencode/

Prompts
-------

======================= ========================================================
`pragmatic-oneshot`_    pragmatic terminal task executor
`aur-to-archlinuxcn`_   add AUR packages to archlinuxcn repo
`general-git-commit`_   general git commit workflow, lower priority
======================= ========================================================

.. _pragmatic-oneshot: agents/agents/pragmatic-oneshot.md
.. _aur-to-archlinuxcn: agents/skills/aur-to-archlinuxcn/SKILL.md
.. _general-git-commit: agents/skills/general-git-commit/SKILL.md

How to?
=======

Run ``./deploy.sh`` to deploy dotfiles via soft link.
