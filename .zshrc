# [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]] \
#    && source /usr/share/oh-my-zsh/oh-my-zsh.sh

export LA_ZSHRC_LOADED=$(($LA_ZSHRC_LOADED+1))

source $HOME/.bashrc

# Prompt {{{1
autoload -U promptinit && promptinit
setopt prompt_subst

## git prompt
## ref: http://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
git_prompt() {
    git rev-parse --git-dir > /dev/null 2>&1 || return

    branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3-)
    tag=$(git describe --tag 2>/dev/null)
    head=$(git rev-parse --short HEAD)

    if [[ ! -z ${branch} ]]; then
        prompt=${branch}
    elif [[ ! -z ${tag} ]]; then
        prompt=${tag}
    else
        prompt=${head}
    fi

    is_clean=$(git status --short)
    if [[ ! -z ${is_clean} ]]; then
        is_clean="%F{yellow}x"
    fi
    echo "%F{blue}git:(%F{red}${prompt}%F{blue}) ${is_clean}%f";
}

## host prompt
host_prompt(){
    if [[ -z ${SSH_CLIENT} ]]; then
        echo '%F{magenta}%m%f'
    else
        echo '%F{magenta}%m (%F{red}remote%F{magenta})%f'
    fi
}

PROMPT=$'%F{green}/%f %B%F{cyan}%n%f %F{white}@%f $(host_prompt) %F{black}%T%f %F{white}->%(?..%F{red}[%?])%f %F{green}%~%f %F$(git_prompt)%f %b
%F{green}\\%f %B%(!.%F{red}%#.%F{blue}$) %F{white}%b'

# History {{{1
HISTSIZE=100000
SAVEHIST=10000
## 不记录重复的历史
setopt HIST_IGNORE_DUPS
setopt share_history
HISTFILE=$HOME/.zsh_history
## 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space

# 补全 {{{1
autoload -U compinit && compinit

setopt AUTO_LIST
setopt AUTO_MENU
unset MENU_COMPLETE         # bash style complete
setopt complete_in_word     # complete /v/c/a/p
setopt no_nomatch		    # enhanced bash wildcard completion
setopt magic_equal_subst
setopt noautoremoveslash
setopt null_glob

## 使用缓存，某些命令的补全很耗时的
zstyle ':completion:*' use-cache on
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
zstyle ':completion:*' cache-path $_cache_dir
unset _cache_dir

## 方向键选中候选项
zstyle ':completion:*' menu select

zstyle ':completion::complete:feh:*' file-patterns '*.{gif,png,jpeg,jpg,svg}:images:images *(-/):directories:directories'


# 目录 {{{1
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


# Key bilding {{{1
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


# Plugins {{{1

## zsh-syntax-highlighting
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

## zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^j' autosuggest-accept

## sphinxnotes-snippet
eval "$(snippet integration --zsh)"
bindkey '^kv' snippet-view
bindkey '^ke' snippet-edit

# vim: se fdm=marker:
