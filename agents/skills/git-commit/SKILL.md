---
name: git-commit
description: 当我要求提交 git 仓库的修改的时候使用
---

# GitHub Commmit Skill

按下面步骤严格执行：

1. 如果当前在 master/main 分支，询问我要不要切换到新分支，若要，分支名称参考已有的分支
2. git add: 如果 staging area 没有文件，询问我要添加哪些文件；否则，直接进入下一步
3. write commit message: 查看待提交文件的历史 commit messages，模仿它们格式编写
4. attach co-author info: 在 commit message body 中加上附加模型的 co-author 信息：
   a. 如果你是 MiniMax，邮箱用 <models@minimax.io>
5. git commit: 执行 git commit
6. git push: 询问我要不要 push
