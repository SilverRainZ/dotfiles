#!/usr/bin/sh

# Set wallpaper wit feh
feh --bg-scale /home/la/Pictures/Wallpapers/blog-bg.jpg &

xflux -l 23 -g 113 -k 4300 &
 
# Load resources
xrdb -merge .Xresources &
 
# Set up an icon tray
trayer --edge top --align right --widthtype percent --width 11 \
       --SetDockType true --SetPartialStrut true --transparent true --alpha 0 \
       --tint 0x000000 --expand true --heighttype pixel --height 17 &
 
# Set up network mananger applet
nm-applet --sm-disable &

fcitx

# Set the background color<
xsetroot -solid midnightblue

