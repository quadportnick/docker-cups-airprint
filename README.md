# znetwork/cups-avahi-airprint [docker-image](https://hub.docker.com/r/znetwork/synology-airprint)

# Working on Synology DSM 7 (!!!) and AMD64

Fork from [quadportnick/docker-cups-airprint](https://github.com/quadportnick/docker-cups-airprint) and [chuckcharlie/docker-cups-airprint](https://github.com/chuckcharlie/docker-cups-airprint)

This Ubuntu-based Docker image runs a CUPS instance that is meant as an AirPrint relay for printers that are already on the network but not AirPrint capable.
* `Included drivers HP, Samsung, Canon, Xerox, etc.`

## Easy run command (use username and password: admin/admin):
```docker run --name airprint --restart unless-stopped --net host znetwork/synology-airprint:latest```

### Before run docker conteiner on DSM7 Synology run this commands in ssh terminal:
* `sudo synosystemctl stop cupsd`
* `sudo synosystemctl stop cups-lpd`
* `sudo synosystemctl stop cups-service-handler`
* `sudo synosystemctl disable cupsd`
* `sudo synosystemctl disable cups-lpd`
* `sudo synosystemctl disable cups-service-handler`

### Add and setup printer:
* CUPS will be configurable at http://[host ip]:631 using the CUPSADMIN/CUPSPASSWORD.
* Make sure you select `Share This Printer` when configuring the printer in CUPS.
* ***After configuring your printer, you need to close the web browser for at least 60 seconds. CUPS will not write the config files until it detects the connection is closed for as long as a minute.***

### After setup and testing AirPrint, you can back run on services. (maybe you will need restart nas)
* `sudo synosystemctl start cupsd`
* `sudo synosystemctl start cups-lpd`
* `sudo synosystemctl start cups-service-handler`
* `sudo synosystemctl anable cupsd`
* `sudo synosystemctl anable cups-lpd`
* `sudo synosystemctl anable cups-service-handler`

## Manual Configuration

### Volumes:
* `/config`: where the persistent printer configs will be stored
* `/services`: where the Avahi service files will be generated

### Variables:
* `CUPSADMIN`: the CUPS admin user you want created - default is `admin` if unspecified
* `CUPSPASSWORD`: the password for the CUPS admin user - default is `admin` username if unspecified

### Ports/Network:
* Must be run on host network. This is required to support multicasting which is needed for Airprint.


### Example run env command:
```
docker run --name cups --restart unless-stopped  --net host\
  -v <your services dir>:/services \
  -v <your config dir>:/config \
  -e CUPSADMIN="<username>" \
  -e CUPSPASSWORD="<password>" \
  znetwork/cups-avahi-airprint:latest
```