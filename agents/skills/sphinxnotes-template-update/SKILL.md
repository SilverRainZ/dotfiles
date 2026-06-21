---
name: sphinxnotes-template-update
description: Use when updating a sphinxnotes project from the cookiecutter template, resolving cruft update conflicts (.rej files), and completing template sync
---

# SphinxNotes 模板更新指南

将上游 cookiecutter 模板的变更同步到当前生成项目。
覆盖完整流程：运行更新、解决合并冲突、验证、提交。

## 0. 环境检查

- 确认 `git`、`jq`、`cruft`、`wiggle` 可用
- 确认工作区干净：`git status --short`
- 确认已同步远程：`git fetch`，检查 `git status` 确认无 ahead/behind

## 1. 判断是否模板问题

- 先确认当前变更是模板问题还是项目问题
- 如果是模板问题，上游 `sphinxnotes/cookiecutter` 的变更应已完成
- 如果变更仅在当前项目有意义，不应通过模板同步处理，直接手工修改即可

## 2. 执行更新

```bash
make tmpl-update
```

这会运行 `cruft update`，将上游模板变更合并到当前项目。

## 3. 处理结果

如果 `cruft update` 顺利完成，无 `.rej` 文件产生，跳至步骤 5 提交。

如果有 `.rej` 文件或三方合并失败，按以下顺序处理：

**自动应用：**

```bash
make tmpl-apply-rej
```

这会用 `wiggle --replace` 尝试自动解决所有 `.rej` 文件。

**手工解决：**

如果 `wiggle` 无法完全解决，需手工处理冲突文件。

**确认清理：**

```bash
find . -name '*.rej'
```

必须确保没有任何残留 `.rej` 文件。

## 4. 验证

```bash
make test
make docs
```

两项都需要通过。如果失败，检查是否冲突解决过程中引入了问题。

## 5. 提交

```bash
make tmpl-update-done
```

这会生成一条 commit message：`chore: Update project template to <owner>/cookiecutter@<commit-hash>`。
