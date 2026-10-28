#!/usr/bin/env bash

options="Suspend
Hibernate
Reboot
Poweroff"

choice=$(printf '%s\n' "$options" | dmenu -i -b -nb '#121212' -nf '#cdcab1' -sb '#242424' -fn 'monospace:10' -p "Power")

case "$choice" in
    Suspend)  loginctl suspend ;;
    Hibernate) loginctl hibernate ;;
    Reboot)   loginctl reboot ;;
    Poweroff) loginctl poweroff ;;
    *) exit 0 ;;
esac
