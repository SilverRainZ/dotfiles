#!/usr/bin/sh

# Make sure we have $SNIPPET
[ -z "$SNIPPET"] && SNIPPET='snippet'

line=$($SNIPPET get --line-start $1)
file=$($SNIPPET get --file $1)"

nvim +$line $file
