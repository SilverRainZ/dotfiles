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

# Java (GUI)
#
# ref: https://wiki.archlinux.org/index.php/Java#Applications_not_resizing_with_WM.2C_menus_immediately_closing
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Wayland compatible.
export MOZ_ENABLE_WAYLAND=1         # for firefox
export QT_QPA_PLATFORM=wayland      # qt
# ref: https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
export XDG_SESSION_TYPE=wayland     # run natively

# Ask wlroot only use the builtin i915 (PCI 00:02.0), regardless of its
# current card number, which shifts when the Nvidia eGPU is plugged/unplugged.
#
# NOTE:
# 1. by-path names contain ':' which conflicts with WLR_DRM_DEVICES's
#    ':'-separated list syntax, so resolve the symlink first.
# 2. device nodes are not regular files, use "-e" instead of "-f" to test them.
_igpu_path=/dev/dri/by-path/pci-0000:00:02.0-card
if [ -e "$_igpu_path" ]; then
    export WLR_DRM_DEVICES=$(readlink -f "$_igpu_path")
fi

# Keep the desktop graphics stack off the eGPU so it never holds /dev/nvidia*
# at idle -- otherwise egpu-detach's "GPU still in use" check fails forever.
# Every GPU app (sway itself, firefox, electron apps) would otherwise open the
# NVIDIA nodes just to enumerate the card. CUDA is unaffected: libcuda talks to
# /dev/nvidia0 directly, not through glvnd/EGL or the Vulkan loader.
#
# EGL: force glvnd to load only the Mesa vendor, never libEGL_nvidia.
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json
# Vulkan: hide the nvidia ICD from the loader (glob matches nvidia_icd.json).
export VK_LOADER_DRIVERS_DISABLE='*nvidia*'
