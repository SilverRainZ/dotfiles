#!/usr/bin/sh

url=$(snippet get --url $1)

xdg-open $url
