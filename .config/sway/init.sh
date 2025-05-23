#!/bin/sh

export LA_SWAY_INIT_LOADED=$(($LA_SWAY_INIT_LOADED+1))

# Language, English by default
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=en_US.UTF-8

# Default util
export BROWSER=firefox
export EDITOR=nvim

# Fcitx moudle
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# Wine.
export WINEARCH=win32
export WINEPREFIX=~/.wine

# GTK?
# TODO

# Qt5
export QT_STYLE_OVERRIDE=breeze
export QT_QPA_PLATFORMTHEME=qt5ct

# Java
#
# ref: https://wiki.archlinux.org/index.php/Java#Applications_not_resizing_with_WM.2C_menus_immediately_closing
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Wayland compatible.
export MOZ_ENABLE_WAYLAND=1         # for firefox
export QT_QPA_PLATFORM=wayland      # qt
# ref: https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
export XDG_SESSION_TYPE=wayland     # run natively
