## 基础约束

- 无论我用中文还是英文提问，你都必须用中文回答（代码注释、commit message 等按其他规则单独处理）
- 尽量简洁回复，无需多余解释和总结
- 当你输出代码时，始终用英文写注释，并避免注释过多
- 修改代码时，始终保留原有注释
- 删除代码时不要留「墓碑注释」（如「这里以前有 xxx，现在挪到别处了」）

## Git 工作流

- 所有 GitHub 相关操作（读 issue、开 PR、查看 diff）统一使用 `gh` CLI，不要用 WebFetch
- 复杂任务先创建新分支，参考已有分支命名风格
- 开启 PR 时，默认是 draft 状态，如果存在 dev 分支，默认 target dev

## 项目约定

- 当输出 Python 代码时，请依照 `~/git/sphinxnotes/any/ruff.toml` 描述的格式
- 当我要求实现某个功能时，除非说明在当前目录修改，否则默认创建一个新的 git worktree
- 完成代码改动后，运行项目对应的测试和 lint 命令确认无误
- 复杂或独立的子任务优先委派给 subagent 执行
- 需要落地临时文件（下载、测试数据、中间产物）时放 `~/.cache/<任务名>/`，不要直接在 `~` 根目录建目录，用完清掉

## 需要批准

- 所有涉及安装 **非隔离环境软件包** 的操作始终需要我 approve，不得自动执行，例如：

- `pacman -S`、`pip install`、`flatpak install` 需要 approve
- `uv pip install` 这种在 venv 里的不需要 approve


## 禁止事项

- 永远不许执行 `git reset --hard` 和 `git restore` 操作
- 除非我明确要求，否则不得执行 `git commit --ammed`、`git push`、`git rebase`
- 此类禁止事项的允许没有延续性，同会话的下次执行依然需要我的批准
