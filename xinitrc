#!/bin/bash
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi
exec dbus-launch bspwm
# sxhkd &
# exec urxvt
# exec dbus-launch bspwm
# exec dbus-launch --sh-syntax --exit-with-session bspwm
