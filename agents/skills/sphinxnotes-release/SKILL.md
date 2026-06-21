---
name: sphinxnotes-release
description: Release workflow for sphinxnotes/cookiecutter generated projects. Use when the user asks to release a new stable version.
---

# SphinxNotes 版本发布指南

Publish a new stable version for sphinxnotes projects.

本 skill 只负责**正式版**发布（`MAJOR.MINOR`），
alpha/beta/rc 版本不在本 skill 范围内。

## 0. 环境检查

- 确认 `git`、`jq`、`cruft`、`wiggle` 可用
- 确认当前在 `master` 分支：`git branch --show-current`
- 确认工作区干净：`git status --short`
- 确认已同步远程：`git fetch`，检查 `git status` 确认无 ahead/behind

## 1. 就绪评估

- 检查 GitHub 上所有 open Issue/PR，结合内容评估是否为 release blocker
- 扫代码中是否有明显未完成的功能（FIXME/TODO 注释、占位实现、未注册的配置项等）
- 梳理风险点，向用户汇报并询问是否继续

## 2. 版本更新

- 版本号遵循：https://sphinx.silverrainz.me/release.html#versioning
- 用 `make bump-version` 升级：
  ```bash
  echo "MAJOR.MINOR" | make bump-version
  ```

## 3. 处理冲突

```bash
make tmpl-apply-rej
```

- 如果还有残留 `.rej` 文件，手工解决冲突
- 确认所有 `.rej` 已清理

## 4. 更新 Changelog

- 检查 `docs/changelog.rst` 中当前版本的条目
  - 如果已有内容但缺 `:date:` → 加上 `:date: YYYY-MM-DD`（日期为今天）
  - 如果没有条目 → 参考 `sphinxnotes-changelog` skill 编写 changelog，
    完成后给用户 review
- `git add docs/changelog.rst`

## 5. 验证

```bash
make test
make docs
```

## 6. 提交并打 tag

```bash
make bump-version-done
```

## 7. 推送

询问用户是否推送，确认后：

```bash
git push && git push --tags
```
