#!/bin/bash
# Aliaes for asking agent to run oneshot task from terminal.
# See also ~/bin/agent-run.

alias r='agent-run'
alias run='agent-run'
alias ok='agent-run --continue ok'
alias cmt='agent-run commit staged files'
alias commit='agent-run commit staged files'
# alias ask='agent-run --tmp'
alias ask='cd /tmp; agent-run'
alias trans='agent-run 翻译这个 文件/网址，直接输出，不要做修改 '

# TODO: Cleanup history
