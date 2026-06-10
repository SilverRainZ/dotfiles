---
name: dotfiles-git-commit
description: 在 dotfiles 项目中，当我要求提交修改时使用
---

# 按应用归类的 Git 提交

## 触发条件

在 dotfiles 项目中，当我说「提交」「commit」且 staging area 包含**多个不同软件/工具**的改动时触发。

以下情况**不触发**本 skill，改用 `general-git-commit`：

- staging area 仅含一个软件的改动
- staging area 仅含项目级文件（`README.rst`、`Makefile`、`deploy.sh`、`.gitignore`、`.gitattributes`、`archpkgs.txt` 等）

## 核心流程

### 第一步：列出 staging 文件

```bash
git diff --cached --name-only
```

### 第二步：按应用分组

根据文件路径提取所属应用作为分组依据：

| 路径模式 | 分组名称/scope |
|----------|---------------|
| `config/<app>/` | 取 `<app>` 名，如 `nvim`、`sway`、`waybar`、`kitty`、`tmux`、`yazi`、`fzf`、`mako`、`alacritty`、`fontconfig`、`srain`、`glow`、`vinput`、`wireplumber` |
| `config/chromium-flags.conf` | `chromium` |
| `home/.*` | 按文件名取，如 `zshrc` → `sh`、`gitconfig` → `git`、`vimrc` → `vim`、`bashrc` → `sh` |
| `bin/` | `bin` |
| `agents/` | 按子路径取，如 `agents/AGENTS.md` → `agents`、`agents/skills/` → `skills` |
| `README.rst` | `README` |
| `.gitignore`、`.gitattributes` | `gitattributes` 或 `gitignore` |
| `Makefile`、`deploy.sh`、`archpkgs.txt` 等根目录文件 | `dotfiles` 或 `scripts` |

**同一分组的文件合并在一个 commit 中。**

### 第三步：阅读改动内容

```bash
git diff --cached
```

理解每组的改动目的。

### 第四步：展示方案

```
计划创建以下 commit：

Commit 1: nvim: Add treesitter config for lua
  - config/nvim/lua/plugin/treesitter.lua

Commit 2: sway: Adjust workspace layout
  - config/sway/config
  - config/sway/init.sh
```

**必须等我确认后再执行。** 若我明确说「直接提交」或你当前不被允许和用户交互，跳过确认。

### 第五步：逐个提交

```bash
git commit -m "<scope>: <description>" -- <文件列表>
```

commit message 规范：
- 格式：`<scope>: <英文描述>`，scope 小写
- 描述改动目的，首字母大写
- 控制在 50 字符内

在 commit body 中附加 co-author 信息（根据实际模型选择邮箱）：
- DeepSeek: `Co-authored-by: DeepSeek <service@deepseek.com>`

```bash
git commit -m "sway: Adjust workspace layout" -m "" -m "Co-authored-by: DeepSeek <service@deepseek.com>" -- config/sway/config
```

完成后展示：

```
✅ 已创建 N 个 commit:
  abc1234 nvim: Add treesitter config for lua
  def5678 sway: Adjust workspace layout
```

## 常见错误

| 错误 | 正确做法 |
|------|----------|
| 同一软件的多个改动分散在不同 commit | 同一分组合并为一个 commit |
| 不同软件的改动混在同一个 commit | 按软件拆分 |
| 项目级文件与某软件文件混在一起 | 项目级文件单独一个 commit |
| commit message 写中文 | 按历史风格写英文 |

## 示例

**Staging：**
- `config/nvim/lua/plugin/treesitter.lua` — 新增 treesitter 配置
- `config/sway/config` — 调整工作区布局
- `config/sway/init.sh` — 同步修改启动脚本
- `home/.zshrc` — 添加别名

**分组：**
- `nvim` → `config/nvim/lua/plugin/treesitter.lua`
- `sway` → `config/sway/config` + `config/sway/init.sh`
- `sh` → `home/.zshrc`

**展示：**
```
Commit 1: nvim: Add treesitter config for lua
  - config/nvim/lua/plugin/treesitter.lua

Commit 2: sway: Adjust workspace layout and startup
  - config/sway/config
  - config/sway/init.sh

Commit 3: sh: Add new aliases
  - home/.zshrc
```
