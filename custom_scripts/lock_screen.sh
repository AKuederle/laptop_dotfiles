#!/bin/sh

exec xautolock \
  -time 5 -locker "i3lock -i ~/Pictures/Backgrounds/main_background.png -e -f --insidevercolor=268bd2bf --insidewrongcolor=dc322fbf --insidecolor=073642bf --ringvercolor=268bd2ff --ringwrongcolor=dc322fff --ringcolor=073642ff --textcolor=839496ff --separatorcolor=073642ff --keyhlcolor=2aa198ff --bshlcolor=cb4b16ff -r" \
  -notify 20 \
  -notifier "notify-send -t 20000 -- 'LOCKING screen soon'" \
  -corners ----