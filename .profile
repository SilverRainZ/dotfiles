export LA_PROFILE_LOADED=$(($LA_PROFILE_LOADED+1))

export VISUAL=vim
export EDITOR=$VISUAL

# Less colorful output
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')

export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# Misc
export CHROOT=$HOME/chroot

# Path {{{1
export PATH=$HOME/bin:$PATH
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin

# macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
    export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
    export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
    export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
    export PATH=$PATH:$HOME/Library/Python/3.9/bin
    export PATH=/usr/local/opt/util-linux/bin:$PATH
    export PATH=/usr/local/opt/util-linux/sbin:$PATH
    export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH
    export PATH=/usr/local/Cellar/gtk4/4.4.1/bin/:$PATH
    # go 1.18
    export PATH=$HOME/git/go/bin:$PATH
fi


# rustup
source $HOME/.cargo/env

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    source ~/.config/sway/pre-startup
    exec sway
fi
