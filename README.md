# chuckcharlie/cups-airprint-brother

Fork from [quadportnick/cups-airprint](https://github.com/quadportnick/docker-cups-airprint)

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

## Using
CUPS will be configurable at http://[diskstation]:631 using the CUPSADMIN/CUPSPASSWORD when you do something administrative.

## Notes
* I had to run the [airprint-generate.py](/root/root/airprint-generate.py) script on the local host to get the avahi service file to generate.
  * `python airprint-generate.py -H localhost -p 631 -u admin -d <your services dir>`
 
