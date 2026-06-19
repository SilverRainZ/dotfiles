---
description: "创建 Pull Request"
---

# 创建 Pull Request

## 流程

1. 如果当前在主分支（main/master）上，先创建新分支。如果已在特性分支上，跳过此步。
2. 如果有未提交的文件，调用 `/commit` 命令
3. 运行 `git status` 检查本地 HEAD 与上游分支是否一致。如果一致，跳过推送。如果不一致或无上游分支，调用 `/push` 命令
4. 运行 `gh pr create`，根据变更内容编写标题和描述。

任何步骤失败则停止并报告错误。
