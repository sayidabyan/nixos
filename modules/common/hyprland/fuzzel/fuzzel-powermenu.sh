#!/bin/sh

SELECTION="$(printf "1 - Lock\n2 - Suspend\n3 - Log out\n4 - Reboot\n5 - Reboot to UEFI\n7 - Shutdown" | fuzzel --dmenu -l 7 -p "Power Menu: ")"

case $SELECTION in
	*"Lock")
		hyprlock;;
	*"Suspend")
    setsid hyprlock >/dev/null 2>&1 & sleep 0.5; systemctl suspend;;
	*"Log out")
		hyprctl dispatch exit 1;;
	*"Reboot")
		reboot;;
	*"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
	*"Shutdown")
		shutdown now;;
esac
