#!/usr/bin/sh

xflux -l 23 -g 113 -k 4300 &
 
# Load resources
xrdb -merge .Xresources &
 
# Set up an icon tray
# install trayer-srg form AUR
trayer --edge top --align right --widthtype percent --width 11 \
       --SetDockType true --SetPartialStrut true --transparent true --alpha 0 \
       --tint 0x000000 --expand true --heighttype pixel --height 18 --monitor primary &
 
# Set up network mananger applet
nm-applet --sm-disable &

# 
pnmixer &

fcitx &

# Set the background color
xsetroot -solid midnightblue &

# Dual screens
xrandr --output VGA-0 --auto --output LVDS --auto --right-of VGA-0 &

# Composite manager
compton -b -c &

# Set wallpaper wit feh
sleep 1 && feh --bg-scale /home/la/Pictures/Wallpapers/bg.jpg &
