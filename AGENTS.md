# dotfiles

Personal machine configuration managed as symlinks. `deploy.sh` (or `make deploy`) links everything into place; configs are edited here, never at the symlink target.

## Layout

| Path | Deployed to | Contents |
|---|---|---|
| `home/` | `~/` | Dotfiles: shell (`.*shrc`, `.profile`), `.gitconfig`, `.vimrc` |
| `config/` | `~/.config/` | XDG app configs: sway, kitty, tmux, nvim, waybar, mako, yazi, pi, ... |
| `bin/` | `~/bin` | User scripts |
| `agents/` | manual symlinks | pi's global agent data (see below) |
| `.agents/skills/` | auto-loaded by pi | Repo-local pi skills (e.g. `dotfiles-git-commit`) |
| `archpkgs.txt` | — | Explicitly installed Arch packages; refresh with `make update-archpkgs` |

The three top-level dirs are linked by `deploy.sh`; `agents/` is wired up by hand:

- `agents/AGENTS.md` → `~/.config/pi/AGENTS.md` (AI agents' instructions, not repo-specific)
- `agents/skills/<name>/` → `~/.agents/skills/<name>/` (own skills, one symlink each)
- `agents/skill-lock.json` → `~/.agents/.skill-lock.json` (manifest of npx-installed third-party skills; restore on a fresh machine with `npx skills experimental_install`)

Third-party skills installed via npx are not vendored — only the lock file is tracked. Own or locally modified skills live in `agents/skills/`.

## Commits

Follow the `dotfiles-git-commit` skill: one intent per commit, `<scope>: <description>` subjects, show the commit plan and wait for approval. Co-author lines per the `model-co-authors` skill.

Keep runtime state out of the repo: `config/pi/mcp.log`, `config/pi/intercom/`, and similar live in `.gitignore`, not history.

## Application Configuration Preference

### pi (`config/pi/`)

- Install/remove extensions with `pi install` / `pi remove`; packages stay pinned in `settings.json`, and every change is committed with its reason.
- Reputable plugins only (the awesome-pi curated list is the reference); nothing that oversteps (auto-commit/push, opaque tool re-registration). Prefer pure render-layer extensions (`registerToolRenderer`) over ones that replace built-in tools.
- Prefer config files under `config/pi/` over environment variables; when a plugin only reads env vars, put them in `home/.profile`.
- After editing `settings.json` with Python's `json.dump`, re-append the trailing newline (`json.dump` strips it).
- Changes apply on `/reload`; `home/.profile` changes need a new shell.
