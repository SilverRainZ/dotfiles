# TTY related setting
# ===================
#
# :date: 2020-02-08

# Use C locale
export LANG=C

# Set TTY font
#
# /usr/share/kbd/consolefonts/
#
# pacman -S terminus-fonts
# ``ter-{*}{12,14,16,18,24,28,32}{n,b}.psf.gz``
#   - {*}: ISO8859-1/2/5/7/9/13/15/16, Paratype-PT154/PT254, KOI8-R/U/E/F,
#     Esperanto, many IBM, Windows and Macintosh code pages,
#     as well as the IBM VGA, vt100 and xterm pseudographic characters.
#   - {number}: size
#   - {n,b}: normal and bold (except for 6x12)
setfont ter-v32b

# Set Color Palette
#
# ref: https://wiki.archlinux.org/index.php/User:Isacdaavid/Linux_Console#Echoing_raw_escape_sequences
# ref: https://github.com/arcticicestudio/nord-tilix
#
# XRRGGBB" where X is the number of 16 color(from 0 to F)
echo -en "\e]P03b4252 " #black,background
echo -en "\e]P1bf616a " #darkred
echo -en "\e]P2a3be8c " #darkgreen
echo -en "\e]P3ebcb8b " #brown
echo -en "\e]P481a1c1 " #darkblue
echo -en "\e]P5b48ead " #darkmagenta
echo -en "\e]P688c0d0 " #darkcyan
echo -en "\e]P7e5e9f0 " #lightgray
echo -en "\e]P84c566a " #darkgray
echo -en "\e]P9bf616a " #red
echo -en "\e]PAa3be8c " #green
echo -en "\e]PBebcb8b " #yellow
echo -en "\e]PC81a1c1 " #blue
echo -en "\e]PDb48ead " #magenta
echo -en "\e]PE8fbcbb " #cyan
echo -en "\e]PFeceff4 " #white,foreground

clear # epaint the whole background with the new color
cat /etc/issue # login splash again

# vim: set filetype=sh:
