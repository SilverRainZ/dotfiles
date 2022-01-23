#!/usr/bin/sh

# Make sure we have $SNIPPET
[ -z "$SNIPPET"] && SNIPPET='snippet'

snippet get --text $1 | bat --language rst --italic-text always --style plain --paging always
