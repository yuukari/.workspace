#!/bin/sh

text=$(cat /tmp/wttr.in.text)
echo "{\"text\":\"$text\"}"