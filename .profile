export LA_PROFILE_LOADED=$(($LA_PROFILE_LOADED+1))

# Use Engish for TUI.
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=en_US.UTF-8

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
    export PATH=$PATH:$HOME/Library/Python/3.10/bin
    export PATH=/usr/local/opt/util-linux/bin:$PATH
    export PATH=/usr/local/opt/util-linux/sbin:$PATH
    export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH
    export PATH=/usr/local/Cellar/gtk4/4.4.1/bin/:$PATH
    export PATH=/usr/local/Cellar/zig/0.9.1_1/bin:$PATH
fi


# Homebrew 
if [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -d /home/linuxbrew ]]; then
    # https://docs.brew.sh/Homebrew-on-Linux
    export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Some patches.
#
# https://github.com/python-poetry/poetry/issues/1917#issuecomment-1235998997
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# rustup
# source $HOME/.cargo/env

# ByteDance private profile
source $HOME/.btprofile

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    source ~/.config/sway/init.sh
    exec sway
fi
