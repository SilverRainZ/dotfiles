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

# Path
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    source ~/.config/sway/pre-startup
    exec sway
fi
