#!/bin/sh

export LA_XINITRC_LOADED=$(($LA_XINITRC_LOADED+1))

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# .xprofile contains some environment varibles
source ~/.xprofile

# Dual screens auto dectection
internal="^\(\(eDP\|LVDS\)-\?[0-9]\+\)"
external="^\(\(VGA\|DVI\|DP\|HDMI\)-\?[0-9]\+\)"
pattern="connected \(primary \)\?\([0-9]\+x\)\?.*$"

inter_scr=$(xrandr 2> /dev/null | grep "$internal $pattern" | sed "s/$internal $pattern/\1/")
exter_scr=$(xrandr 2> /dev/null | grep "$external $pattern" | sed "s/$external $pattern/\1/")

if [ ! -z "$exter_scr" ] ; then
    xrandr --output ${exter_scr} --auto --output ${inter_scr} --primary --auto --right-of ${exter_scr}
fi

# Load resources
xrdb -merge .Xresources &

xflux -l 23 -g 113 -k 4300 &

# Composite manager
compton -b -c &

# Set up an icon tray
# trayer DOESN'T support `--monitor` option, pls install trayer-srg form AUR
trayer --edge top --align right --widthtype percent --width 11 \
       --SetDockType true --SetPartialStrut true --transparent true --alpha 0 \
       --tint 0x1a1a1a --expand true --heighttype pixel --height 18 --monitor primary &

# Set up network mananger applet
nm-applet --sm-disable &

#
pnmixer &

fcitx5 &

# Set the background color
xsetroot -solid midnightblue &

# Set wallpaper wit feh
sleep 0.2 && feh --bg-scale /home/la/pictures/bg.png

# Key bindings
xbindkeys &

# xscreensaver -no-splash &

numlockx on &

touchpad &

sleep 0.2 && exec xmonad
