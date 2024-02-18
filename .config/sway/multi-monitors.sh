#!/bin/sh

# All known monitors.
OUT_BUILTIN='eDP-1'
OUT_BENQ='BNQ BenQ EW3270U 58K06820019'
OUT_DELL='Dell Inc. DELL U2720Q FZXCY13'

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
else
    echo Output: ALL
    swaymsg "output * scale 2.3"
fi
