# chuckcharlie/cups-airprint-brother

Fork from [quadportnick/docker-cups-airprint](https://github.com/quadportnick/docker-cups-airprint)

This Ubuntu-based Docker image runs a CUPS instance that is meant as an AirPrint relay for printers that are already on the network but not AirPrint capable. I am running this on CentOS. I forked the original to add support for my Brother MFC-7840w printer, and use the latest Ubuntu base.

## Prereqs
* Install avahi on local host.
  * `yum install avahi`
  * `systemctl start avahi-daemon`
  * `systemctl enable avahi-daemon` 

## Configuration

### Volumes:
* `/config`: where the persistent printer configs will be stored
* `/services`: where the Avahi service files will be generated

### Variables:
* `CUPSADMIN`: the CUPS admin user you want created
* `CUPSPASSWORD`: the password for the CUPS admin user

### Ports:
* `631`: the TCP port for CUPS must be exposed

### Example run command:
```
docker run --name cups -p 631:631   --restart unless-stopped  \
  -v /opt/cups/services:/services \
  -v /opt/cups/config:/config \
  -v /var/run/dbus:/var/run/dbus \
  -e CUPSADMIN="<username>" \
  -e CUPSPASSWORD="<password>" \
  chuckcharlie/cups-airprint-brother:latest
```

## Using
CUPS will be configurable at http://[host ip]:631 using the CUPSADMIN/CUPSPASSWORD when you do something administrative.

## Notes
* I had to run the [airprint-generate.py](/root/root/airprint-generate.py) script on the local host to get the avahi service file to generate.
  * `python airprint-generate.py -H localhost -p 631 -u admin -d <your services dir>`
 
