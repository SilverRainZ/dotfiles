# [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]] \
#    && source /usr/share/oh-my-zsh/oh-my-zsh.sh

source $HOME/.bashrc

# Prompt
autoload -U promptinit && promptinit
setopt prompt_subst

## git prompt
## ref: http://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
git_prompt() {
    git rev-parse --git-dir > /dev/null 2>&1 && \
        branch=$(git symbolic-ref HEAD | cut -d'/' -f3)

    if [[ -z $branch ]]; then
        echo $branch
    else
        is_clean=$(git status --short)
        if [[ ! -z $is_clean ]]; then
            is_clean="%F{yellow}x"
        fi
        echo "%F{blue}git:(%F{red}$branch%F{blue}) $is_clean%f";
    fi
}

PROMPT=$'/%B%F{cyan} %n %F{white}@ %F{magenta}%m %F{black}%T %F{white}->%(?..%F{red}[%?]) %F{green}%~ $(git_prompt) %b
\\ %B%(!.%F{red}%#.%F{blue}$) %F{white}%b'


# History
HISTSIZE=100000
SAVEHIST=10000
## 不记录重复的历史
setopt HIST_IGNORE_DUPS
setopt share_history
HISTFILE=$HOME/.zsh_history

# 补全
autoload -U compinit && compinit

setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE
setopt complete_in_word   # complete /v/c/a/p
setopt no_nomatch		  # enhanced bash wildcard completion
setopt magic_equal_subst
setopt noautoremoveslash
setopt null_glob

## 方向键选中候选项
zstyle ':completion:*' menu select

zstyle ':completion::complete:feh:*' file-patterns '*.{gif,png,jpeg,jpg,svg}:images:images *(-/):directories:directories'


# 目录
setopt auto_cd      # if not a command, try to cd to it.

## 目录栈
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
fi

chpwd() {
    print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
## This reverts the +/- operators.
setopt pushdminus


# Key bilding
bindkey -e

## Functional key
bindkey  "${terminfo[khome]}"   beginning-of-line
bindkey  "${terminfo[kend]}"    end-of-line
bindkey  "${terminfo[kich1]}"   overwrite-mode
bindkey  "${terminfo[kbs]}"     backward-delete-char
bindkey  "${terminfo[kcuu1]}"   up-line-or-history
bindkey  "${terminfo[kcud1]}"   down-line-or-history
bindkey  "${terminfo[kcub1]}"   backward-char
bindkey  "${terminfo[kcuf1]}"   forward-char
bindkey  "${terminfo[kdch1]}"   delete-char # original: kdch1=\E[3~


## <- and -> (Linux only?)
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

## Search in history (thx lilydjwg :D)
bindkey '^[p' up-line-or-search
bindkey '^[n' down-line-or-search


# Plugin
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
