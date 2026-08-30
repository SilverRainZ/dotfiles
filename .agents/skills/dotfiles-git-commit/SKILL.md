---
name: dotfiles-git-commit
description: 在 dotfiles 项目中，当我要求提交修改时使用
---

# 按变更意图归类的 Git 提交

## 触发条件

在 dotfiles 项目中，当我说「提交」「commit」且 staging area 包含**多个不同软件/工具**的改动时触发。

以下情况**不触发**本 skill，改用 `general-git-commit`：

- staging area 仅含项目级文件（`README.rst`、`Makefile`、`deploy.sh`、`.gitignore`、`.gitattributes`、`archpkgs.txt` 等）

## 核心流程

### 第一步：列出 staging 文件

```bash
git diff --cached --name-only
```

### 第二步：按变更意图分组

先把为同一用户可见行为而改动、且必须一起生效的文件放进同一 commit；只有彼此独立的改动才拆分。目录和应用仅用于选 commit scope，不是拆分依据。

根据主要改动路径提取 scope：

| 路径模式 | 建议 scope |
|----------|-------------|
| `config/<app>/` | 取 `<app>` 名，如 `nvim`、`sway`、`waybar`、`kitty`、`tmux`、`yazi`、`fzf`、`mako`、`alacritty`、`fontconfig`、`srain`、`glow`、`vinput`、`wireplumber` |
| `config/chromium-flags.conf` | `chromium` |
| `home/.*` | 按文件名取，如 `zshrc` → `sh`、`gitconfig` → `git`、`vimrc` → `vim`、`bashrc` → `sh` |
| `bin/` | `bin` |
| `agents/` | 按子路径取，如 `agents/AGENTS.md` → `agents`、`agents/skills/` → `skills` |
| `README.rst` | `README` |
| `.gitignore`、`.gitattributes` | `gitattributes` 或 `gitignore` |
| `Makefile`、`deploy.sh`、`archpkgs.txt` 等根目录文件 | `dotfiles` 或 `scripts` |

**例如：**重命名 `bin/icat` 为 `bin/la-print`，并在 `home/.sh/alias.sh` 加 `p` alias，是同一功能，合并为 `bin: Replace icat with Nushell la-print`。

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
- 描述改动目的，首字母大写；迁移或行为变化要点明关键实现
- 控制在 50 字符内
- 例如：`bin: Replace icat with Nushell la-print`
- 非显而易见的约束或取舍，在 body 简短说明为什么

在 commit body 中附加 co-author 信息，参见 `model-co-authors` skill：

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
| 为同一功能服务的跨目录改动被拆开 | 按功能合并，例如命令与其 shell alias |
| 同一软件的独立功能混在同一个 commit | 按独立变更意图拆分 |
| 仅因路径不同而拆分 | 路径只决定 scope，不决定 commit 边界 |
| commit message 写中文 | 按历史风格写英文 |

## 仓库历史中的典型示例

| Commit | 说明 |
|--------|------|
| `0fe0cc3 bin: Replace icat with la-print` | 删除旧命令、添加替代命令和 shell alias 跨越两个路径，但共同构成一次迁移，应合并。 |
| `455cfe8 pi: Introduce Pi coding agent` | 多个 Pi 配置与 `home/.profile` 一起交付同一能力；文件多不等于应拆分。 |
| `0473a43 tmux: Add copy-mode bindings for fzf-url` | 单应用、单能力的最小 commit。 |
| `b05b580 sway: Pin WLR_DRM_DEVICES to iGPU by PCI path, not card number` | 非显而易见的约束在 commit body 说明“为什么”，subject 保持具体。 |
| `c6dca8e skills: Recommend http proxy for python tools` | 单个 skill 的文档调整独立提交，不与无关配置混合。 |
