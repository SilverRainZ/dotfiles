#!/bin/sh
# https://github.com/swaywm/sway/wiki#clamshell-mode

# All known monitors.
OUT_BUILTIN='eDP-1'
OUT_BENQ='BNQ BenQ EW3270U 58K06820019'
OUT_DELL='Dell Inc. DELL U2720Q FZXCY13'
OUT_CHANGHONG='ChangHong Electric Co.,Ltd CHFHD 0x00000001'
OUT_SANC='SAC HDMI 000000010000'

clamshell_mode() {
    swaymsg "bindswitch --reload --locked lid:off output $1 enable"
    swaymsg "bindswitch --reload --locked lid:on output $1 disable"
}

outputs=$(swaymsg --pretty --type get_outputs)
echo $outputs

if echo "$outputs" | grep "$OUT_BENQ"; then
    echo Output: $OUT_BENQ
    swaymsg "output '$OUT_BENQ' scale 1.5 pos 0 0"
    swaymsg "output '$OUT_BUILTIN' scale 2.5 pos 0 1440"
    clamshell_mode "$OUT_BUILTIN"
elif echo "$outputs" | grep "$OUT_DELL"; then
    echo Output: $OUT_DELL
    swaymsg "output '$OUT_BUILTIN' scale 2.5 pos 0 0"
    swaymsg "output '$OUT_DELL' scale 1.5 pos 2560 0" # 3860/1.5 = 2560
    clamshell_mode "$OUT_BUILTIN"
elif echo "$outputs" | grep "$OUT_CHANGHONG"; then
    swaymsg "output '$OUT_CHANGHONG' scale 2.0 pos 0 0"
    swaymsg "output '$OUT_BUILTIN' scale 3.0 pos 0 520" # 1080/2
    clamshell_mode "$OUT_BUILTIN"
elif echo "$outputs" | grep "$OUT_SANC"; then
    swaymsg "output '$OUT_SANC' scale 1.0 pos 0 0"
    swaymsg "output '$OUT_BUILTIN' scale 3.0 pos 0 1080"
    clamshell_mode "$OUT_BUILTIN"
else
    echo Output: ALL
    swaymsg "output * scale 2.5"
fi

# Prevent bulitin display is enabled when laptop lid is closed.
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"
read -r LS < "$LID_STATE_FILE"
case "$LS" in
    *open)   swaymsg output "$OUT_BUILTIN" enable;;
    *closed) swaymsg output "$OUT_BUILTIN" disable;;
    *)       echo "could not get lid state" >&2 ; exit 1;;
esac
