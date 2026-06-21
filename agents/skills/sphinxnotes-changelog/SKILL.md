---
name: sphinxnotes-changelog
description: Write and maintain changelogs for sphinxnotes projects. Covers preparing release changelogs, adding incremental entries, and the ``.. version::`` directive reference.
---

# SphinxNotes Changelog 编写指南

## 场景 1：为即将发布的版本编写 changelog

从上次正式发布至今的所有变更整理成 changelog。

### 步骤

1. **确定基线版本**：找到 `docs/changelog.rst` 中最后一个带有 `:date:` 的稳定版本
2. **收集变更**：`git log <last-tag>..HEAD`
3. **分类整理**：按类别归纳（新功能、修复、重构、文档等）
4. **编写条目**：在文件顶部创建 `.. version::` 块，不加 `:date:`（表示尚未发布）
5. **发布时**：加上 `:date:`，并按主版本号放入正确的 section

### 模板

```rst
.. version:: 3.0

   - Add new feature (:issue:`42`)
   - Fix some bug (:pull:`10`)
```

发布后变为：

```rst
.. version:: 3.0
   :date: 2025-01-15

   - Add new feature (:issue:`42`)
   - Fix some bug (:pull:`10`)
```

## 场景 2：为正在开发的新功能加一行 changelog

日常开发中，每完成一个值得一提的变更，立即添加条目。

1. 打开 `docs/changelog.rst`，找到顶部未发布版本的 `.. version::` 块
2. 如果还不存在，先创建一个（见场景 1）
3. 在条目列表中添加一行

## changelog 文件结构

```
.. This file is generated from sphinx-notes/cookiecutter.

==========
Change Log
==========

.. hint:: Release strategy reference link

Version 3.x
===========

.. version:: 3.0                      ← 当前开发版本（无 :date:）

   - New feature in progress

.. version:: 2.5                      ← 已发布版本
   :date: 2024-08-17

   - Released feature

Version 2.x
===========

.. version:: 2.4.0
   :date: 2023-08-26

   - Older release
```

## 条目编写约定

- 祈使句："Add ...", "Fix ...", "Support ...", "Drop ..."
- 一条条目对应一个逻辑变更，粒度适中
- 用 `(:issue:\`N\`)` 引用 issue，`(:pull:\`N\`)` 引用 PR
- 用 `:confval:\`name\`` 引用配置项
- 用 `**BREAKING**:` 标记不兼容变更，并在指令上加 `:break:`

### 关联 issue / PR 的查找

为每个变更写条目时，如果存在对应的 issue 或 PR，必须引用。查找途径（按优先级）：

1. **merge commit 信息**：合并 PR 时，merge commit message 通常包含 `(#N)` 格式的 PR 编号
2. **commit log**：提交信息中可能引用 issue（如 `fix #N`、`closes #N`），可运行 `git log <last-tag>..HEAD --oneline` 查看
3. **gh CLI**：用 `gh pr list --state merged` 查看已合入的 PR，`gh issue list` 查看相关 issue

**优先级原则：issue > PR**。如果一个 PR 修复了某个 issue，引用 issue 而非 PR。例如：

- `Fix referenceable field with multiple lines form (:issue:\`34\`)` — 即使通过 PR 实现，也引用 issue
- `Add new Sphinx Domain classifier (:pull:\`27\`)` — 纯功能 PR，无对应 issue 时引用 PR

### 条目风格

简短条目：

```rst
- Add new Sphinx Domain classifier (:pull:`27`)
- Fix referenceable field with multiple lines form (:issue:`34`)
```

带前缀（推荐）：

```rst
- feat: Support multiple MIDI outputs (:pull:`45`)
- fix: Convert MIDI track name to utf-8 (:pull:`47`)
- refactor: Builder that supports strike_node does not need to insert itself
- ci: No longer need checkout submodules
- docs: Update installation guide
```

带子条目的分组：

```rst
- Render ability improvements (:issue:`30`)

  - **BREAKING**: The ``any_schemas`` confval is replaced
  - Add object embedding support (:issue:`28`)
  - Support datetime type in field
```

不兼容变更分组：

```rst
- **BREAKING** changes:

  - Drop ``:noheader``, ``:nofooter:`` options
  - Drop ``:audio:`` option and introduce ``:noaudio:``

.. seealso:: The 3.0 tracking issue: :issue:`15`

.. warning:: This is a BREAKING change to builders that support this role.
```

### 分类前缀

| 前缀 | 适用场景 |
|------|----------|
| `feat:` | 新功能 |
| `fix:` | 修复 bug |
| `refactor:` | 代码重构 |
| `ci:` | CI/CD 相关 |
| `docs:` | 文档变更 |

---

## 附录：`.. version::` 指令参考

changelog 使用 `sphinxnotes-project` 提供的 `.. version::` 指令来结构化记录版本发布。

### 依赖

在 `conf.py` 中启用 `sphinxnotes.project` 扩展：

```python
extensions = ['sphinxnotes.project']
```

### 语法

```rst
.. version:: <版本号>
   :date: <发布日期>
   :break:

   <变更日志内容>
```

### 选项

| 选项 | 类型 | 说明 |
|------|------|------|
| `date` | date | 发布日期，格式 `YYYY-MM-DD` |
| `break` | flag | 标记为不兼容变更 |

### 示例

已发布版本：

```rst
.. version:: 2.5
   :date: 2024-08-17

   - Add new Sphinx Domain classifier (:pull:`27`)
   - Fix referenceable field with multiple lines form (:issue:`34`)
```

不兼容变更：

```rst
.. version:: 3.0
   :break:

   - **BREAKING**: The ``any_schemas`` confval is replaced
   - Add object embedding support (:issue:`28`)
```

开发中版本（无日期）：

```rst
.. version:: 4.0

   - Work in progress feature (:issue:`100`)
```

### 工作原理

1. 版本号作为对象名称，可被 `:version:` 角色引用
2. 提供 `date` 时显示格式化日期（按年份分组索引），并自动生成 GitHub release tag 链接
3. 未提供 `date` 时显示"仍在开发中"提示
4. 设置 `break` 标志时显示不兼容变更警告
5. 内容块直接作为变更日志显示

### 交叉引用

```rst
- LaTeX builder support (Since :version:`1.5`)
- Jianpu support (Since :version:`1.6.0`)
```

### 注意事项

- `date` 的值自动按年份分组创建索引
- `tag` 角色自动生成 GitHub release 链接（基于版本号）
