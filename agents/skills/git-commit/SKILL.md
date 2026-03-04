---
name: git-commit
description: 当我要求提交 git 仓库的修改的时候使用
---

# GitHub Commmit Skill

按下面步骤严格执行：

1. create new branch: 
   - 如果改动很大（修改多个文件、超过 50 lines、修改伴随了测试）且当前在 master/main 分支，询问我要不要切换到新分支，若要，分支名称参考已有的分支
   - 否则，进入下一步
2. git add: 如果 staging area 没有文件，询问我要添加哪些文件；否则，直接进入下一步
3. write commit message: 查看待提交文件的历史 commit messages，模仿它们格式编写
4. attach co-author info: 如果你参与了代码的修改，在 commit message body 中加上附加模型的 co-author 信息：
   - 如果你是 MiniMax，邮箱用 <models@minimax.io>
5. git commit: 执行 git commit
6. git push: 
   - 如果我的消息最后附加了一行 "push"，执行 git push 
   - 如果附加了了 "nopush"，不执行 git push 
   - 否则，则询问我要不要 push
