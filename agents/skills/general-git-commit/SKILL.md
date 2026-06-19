---
name: general-git-commit
description: General git commit workflow, lower priority — only use when user asks to commit changes, and no other commit skill is active
---

# GitHub Commmit Skill

按下面步骤严格执行：

1. create new branch: 
   - 如果改动较大（修改多个文件、超过 50 lines、修改有专门的测试）且当前在 master/main 分支，用户不介意被提问则询问用户要不要切换到新分支，用户不希望提问则直接创建新分支，分支名称参考已有的分支
   - 否则，进入下一步
2. git add: 
   - 如果用户提及要添加哪些文件，添加之
   - 如果没有且 staging area 没有文件，询问我要添加哪些文件
   - 否则，直接进入下一步
3. write commit message: 结合改动内容编写 commit meesage，
   消息格式要模仿对应文件的历史 commit messages
4. attach co-author info: 如果你参与了代码的修改，在 commit message body 中附加 co-author 信息，参见 `model-co-authors` skill
5. git commit: 执行 git commit
6. git push: 如果用户提到了 push 就执行 git push 

   执行 push 时如何遇到 remote 不一致的情况，立刻停止并提醒我
