# quadportnick/cups-airprint
This Ubuntu-based Docker image runs a CUPS instance that is meant as an AirPrint relay for printers that are already on the network but not AirPrint capable. I'm using it on a Synology NAS because for whatever reason the built in functionality is broken. So here we are...

The Synology's CUPS is turned off and the local Avahi will be utilized for advertising the printers on the network.

## Setting it up

From the Synology CLI:
~~~
sudo docker pull quadportnick/cups-airprint
mkdir -p /volume1/docker/cups-airprint
sudo docker create --name cups-airprint -e CUPSADMIN=cups -e CUPSPASSWORD=cupZZZ! -v /volume1/docker/cups-airprint:/config -v /etc/avahi/services:/services -p 631:631 quadportnick/cups-airprint
~~~

Now set auto-start in the Synology DSM interface and start the container. CUPS will be configurable at http://[diskstation]:631 using the CUPSADMIN/CUPSPASSWORD when needed.

## Notes
* CUPS doesn't like printers.conf being mounted directly as it appears to delete/recreate it with changes, so we copy it in on start and then watch for it to change to make a backup of it.
* Watching for the printers.conf file changing also triggers generating the Avahi services. Thanks to @thfontaine for the script! <https://github.com/tjfontaine/airprint-generate>

 
