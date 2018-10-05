#
# ~/.bash_profile
#

export LA_BASH_PROFILE_LOADED=$(($LA_BASH_PROFILE_LOADED+1))

[[ -f ~/.profile ]] && . ~/.profile
[[ -f ~/.bashrc ]] && . ~/.bashrc
