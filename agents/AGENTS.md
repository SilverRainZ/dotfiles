## 基础约束

- 日常对话使用中文，即使我使用英文发出指令，请尽量用中文回答我
- 尽量简洁回复，无需多余解释和总结
- 当你输出代码时，始终用英文写注释，并避免注释过多
- 修改代码时，始终保留原有注释

## Git 工作流

- 所有 GitHub 相关操作（读 issue、开 PR、查看 diff）统一使用 `gh` CLI，不要用 WebFetch
- 复杂任务先创建新分支，参考已有分支命名风格
- commit message 模仿该文件的历史 commit messages 风格
- 当你参与了代码的修改，在 commit message body 中附加 co-author 信息：
  - DeepSeek → `Co-authored-by: DeepSeek <service@deepseek.com>`
  - MiniMax → `Co-authored-by: MiniMax <model@minimax.io>`
  - OpenAI → `Co-authored-by: OpenAI <noreply@openai.com>`
- push 前检查 remote 一致性，不一致则停止并提醒我

## 项目约定

- 当输出 Python 代码时，请依照 `~/git/sphinxnotes/any/ruff.toml` 描述的格式
- 当我要求实现某个功能时，除非说明在当前目录修改，否则默认创建一个新的 git worktree
- 完成代码改动后，运行项目对应的测试和 lint 命令确认无误
- 复杂或独立的子任务优先委派给 subagent 执行

## 禁止事项

- 永远不许执行 `git reset --hard` 和 `git restore` 操作
- 除非我明确要求，否则不得执行 `git commit`、`git push`
