#!/bin/bash

updates=$(zypper lu 2> /dev/null | wc -l)

if [ "$updates" -gt 3 ]; then
    updates=$((updates - 2))
else
    updates=0
fi

threshhold_green=0
threshhold_yellow=25
threshhold_red=100

css_class="green"

if [ "$updates" -gt $threshhold_yellow ]; then
    css_class="yellow"
fi

if [ "$updates" -gt $threshhold_red ]; then
    css_class="red"
fi

if [ "$updates" -gt $threshhold_green ]; then
    printf '{"text": "%s", "alt": "%s", "tooltip": "Update your system", "class": "%s"}' "$updates" "$updates" "$css_class"
else
    printf '{"text": "0", "alt": "0", "tooltip": "No updates available", "class": "green"}'
fi
