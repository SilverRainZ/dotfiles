#!/usr/bin/sh
## # Author: ervandew
# Source: https://github.com/ervandew/dotfiles/blob/master/bin/dzen2
#
# Wrapper around dzen2 that allows width and x to be defined as a screen
# percentage.  The percentage width is define via the new '-wp' arg and
# percentage x as -xp, both of which must be supplied before any other dzen
# arguments.
#
#   $ dzen2 -wp 30 -xp 60 ...
##

external="^\(VGA\|DVI\|DP\|HDMI\)-\?[0-9]\+"
internal="^\(eDP\|LVDS\)-\?[0-9]\+"
pattern="connected \(primary \)\?\([0-9]\+\)x.*$"
# get internal monitor's width only
width=$(xrandr 2> /dev/null | grep "$internal $pattern" | sed "s/$internal $pattern/\3/")
# width=$(xrandr 2> /dev/null | grep "$external $pattern" | sed "s/$external $pattern/\3/")

echo $width
while [ 1 ] ; do
    if [ "$1" == "-wp" ] ; then
        arg="$arg -w `expr $(expr $width '*' $2) / 100`"
    elif [ "$1" == "-xp" ] ; then
        arg="$arg -x `expr $(expr $width '*' $2) / 100`"
    else
        break
    fi
    shift
    shift
done

FG='#aaaaaa'
BG='#1a1a1a'
FONT='-*-terminus-*-r-normal-*-*-110-*-*-*-*-iso8859-*'

cat - | dzen2 $arg "$@" -bg $BG -fg $FG -fn $FONT -e 'button2=;' -xs 1
