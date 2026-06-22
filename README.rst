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

Agents & Skills
----------------

================================ ==============================================
`pragmatic-oneshot`_             pragmatic terminal task executor
`aur-to-archlinuxcn`_            add AUR packages to archlinuxcn repo
`general-git-commit`_            general git commit workflow, lower priority
`grill-me`_                      interview the user relentlessly about a plan
                                 or design
`model-co-authors`_              AI model co-author info for git commit
`sphinxnotes-changelog`_         write and maintain changelogs for sphinxnotes
                                 projects
`sphinxnotes-release`_           release workflow for sphinxnotes projects
`sphinxnotes-template-update`_   update sphinxnotes project from cookiecutter
                                 template
================================ ==============================================

.. _pragmatic-oneshot: agents/agents/pragmatic-oneshot.md
.. _aur-to-archlinuxcn: agents/skills/aur-to-archlinuxcn/SKILL.md
.. _general-git-commit: agents/skills/general-git-commit/SKILL.md
.. _grill-me: agents/skills/grill-me/SKILL.md
.. _model-co-authors: agents/skills/model-co-authors/SKILL.md
.. _sphinxnotes-changelog: agents/skills/sphinxnotes-changelog/SKILL.md
.. _sphinxnotes-release: agents/skills/sphinxnotes-release/SKILL.md
.. _sphinxnotes-template-update: agents/skills/sphinxnotes-template-update/SKILL.md

How to?
=======

Run ``./deploy.sh`` to deploy dotfiles via soft link.
