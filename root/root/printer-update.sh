#!/bin/sh
/usr/bin/inotifywait -m -e close_write,moved_to,create /etc/cups | 
while read -r directory events filename; do
	if [ "$filename" = "printers.conf" ]; then
		rm -rf /services/AirPrint-*.service
		rm -rf /etc/avahi/services/AirPrint-*.service
		/root/airprint-generate.py -d /services
		cp /etc/cups/printers.conf /config/printers.conf
		cp -f /services/AirPrint-*.service /etc/avahi/services/ &
		/usr/sbin/avahi-daemon --reload
	fi
done
