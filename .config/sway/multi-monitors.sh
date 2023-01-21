#!/bin/sh

# All known monitors.
OUT_BUILTIN='eDP-1'
OUT_BENQ='BenQ Corporation BenQ EW3270U 58K06820019'
OUT_DELL='Dell Inc. DELL U2720Q FZXCY13'

clamshell_mode() {
    bindswitch --reload --locked lid:off output $1 enable
    bindswitch --reload --locked lid:on output $2 disable
}

outputs=$(swaymsg -t get_outputs)

if $(echo "$outputs" | grep "$OUT_BENQ"); then
    swaymsg "output '$OUT_BUILTIN' scale 1.5 pos 0 0"
    swaymsg "output '$OUT_BENQ' scale 2.5 pos 0 1440"
    clamshell_mode "$OUT_BUILTIN" "$OUT_BENQ"
elif $(echo "$outputs" | grep "$OUT_DELL"); then
    swaymsg "output '$OUT_BUILTIN' scale 1.5 pos 0 0"
    swaymsg "output '$OUT_DELL' scale 2.5 pos 2560 0" # 3860/1.5 = 2560
    clamshell_mode "$OUT_BUILTIN" "$OUT_DELL"
else
    swaymsg "output * scale 2.2"
fi
