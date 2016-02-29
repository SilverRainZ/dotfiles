#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# .xprofile contains some environment varibles
source ~/.xprofile

# Load resources
xrdb -merge .Xresources &

xflux -l 23 -g 113 -k 4300 &

# Composite manager
compton -b -c &

# Set up an icon tray
# trayer DOESN'T support `--monitor` option, pls install trayer-srg form AUR
trayer --edge top --align right --widthtype percent --width 10 \
       --SetDockType true --SetPartialStrut true --transparent true --alpha 0 \
       --tint 0x1a1a1a --expand true --heighttype pixel --height 18 --monitor primary &

# Set up network mananger applet
nm-applet --sm-disable &

#
pnmixer &

fcitx &

# Set the background color
xsetroot -solid midnightblue &

# Dual screens
xrandr --output DP2 --auto --output eDP1 --auto --right-of DP2 &&

# Set wallpaper wit feh
sleep 0.2 && feh --bg-scale /home/la/Pictures/Wallpapers/bg.jpg &

# key bindings
xbindkeys &

sleep 0.2 && exec xmonad
