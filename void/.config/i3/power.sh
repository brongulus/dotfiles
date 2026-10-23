#!/usr/bin/env bash

options="Reboot
Suspend
Hibernate
Poweroff"

choice=$(printf '%s\n' "$options" | dmenu -i -b -nb '#121212' -nf '#cdcab1' -sb '#242424' -fn 'monospace:10' -p "Power")

case "$choice" in
    Reboot)   loginctl reboot ;;
    Suspend)  loginctl suspend ;;
    Hibernate) loginctl hibernate ;;
    Poweroff) loginctl poweroff ;;
    *) exit 0 ;;
esac
