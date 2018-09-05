#!/bin/sh
xrdb ~/.Xresources &
xmodmap ~/.xmodmap &
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh &
(xset fp+ ~/.local/share/fonts/ && xset fp rehash) &
exec /usr/local/bin/i3
