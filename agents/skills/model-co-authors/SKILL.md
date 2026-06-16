---
name: model-co-authors
description: 提供 AI 模型 co-author 信息，供其他 git commit skill 引用
---

# Model Co-Authors

当在 commit message body 中附加 co-author 信息时，根据当前使用的模型选择对应邮箱：

| 模型 | co-author 行 |
|------|-------------|
| MiMoCode | `Co-authored-by: MiMoCode <mimo@xiaomi.com>` |
| MiniMax | `Co-authored-by: MiniMax <model@minimax.io>` |
| GPT/Codex | `Co-authored-by: GPT <noreply@openai.com>` |
| DeepSeek | `Co-authored-by: DeepSeek <service@deepseek.com>` |

## 格式

```bash
git commit -m "<message>" -m "" -m "Co-authored-by: <Model> <email>"
```

## 规则

- 只有当你参与了代码/文档修改时才附加 co-author
- 仅附加一个 co-author（即当前模型）
