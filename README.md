## HomeSeer HS3 Docker Image

This image containerizes the HomeSeer HS3 home automation software. 

Current HomeSeer version: **HS3 3.0.0.548**

### Running the HomeSeer Container

```
docker run -d \
    --name homeseer \
    -v /opt/homeseer:/HomeSeer \
    -v /etc/localtime:/etc/localtime:ro \
    -p 80:80 \
    -p 10200:10200 \
    -p 10300:10300 \
    -p 10401:10401 \
    -p 11000:11000 \
    --device /dev/ttyUSB0 \
    marthoc/homeseer:latest
```
#### Options:  
`--name homeseer`: Names the container "homeseer".  
`-v /opt/homeseer:/HomeSeer`: Bind mount /opt/homeseer (or the directory of your choice) into the container for persistent storage. This directory on the host will contain the complete HomeSeer installation and could be moved between systems if necessary (be sure to shutdown HomeSeer cleanly first, via Tools - System - Shutdown HomeSeer).  
`-v /etc/localtime:/etc/localtime:ro`: Ensure the container has the correct localtime.  
`-p 80:80`: Port 80, used by the HomeSeer web user interface (specify a different WebUI listen port by changing the first number, e.g. `-p 8080:80` to listen on port 8080 instead).  
`-p 10200:10200`: Port 10200, used by HSTouch.  
`-p 10300:10300`: Port 10300, used by myHS.  
`-p 10401:10401`: Port 10401, used by speaker clients.  
`-p 11000:11000`: Port 11000, used by the ASCII interface.  
`--device /dev/ttyUSB0`: Pass a USB device at /dev/ttyUSB0 (i.e. a USB Z-Wave interface) into the container; replace `ttyUSB0` with the actual name of your device (e.g. ttyUSB1, ttyACM0, etc.).  
`marthoc/homeseer:latest`: See below for descriptions of available image tags.

### Available Image Tags

| Tag | Description |
|-----|-------------|
| `latest` | The latest version of HomeSeer 3 for Linux including avahi-daemon and dbus-daemon for wider plugin support|


### Updating HomeSeer

This image will be updated shortly after a new version of HomeSeer for Linux is released. To update, do...

`docker stop homeseer` [or, whatever name you gave to the container via the `--name` parameter]
`docker rm homeseer` [or, whatever name you gave to the container via the `--name` parameter]
`docker pull marthoc/homeseer`

...then re-create your container using the same command-line parameters used at first run. The new HomeSeer version will be downloaded and installed when the container is run. Your existing user data, plugins, etc., will be preserved.

### Gotchas / Known Issues

HomeSeer is fundamentally a Windows program that runs under the Mono framework on Linux. As such, it does not correctly respond to Unix signals (e.g. SIGTERM, SIGKILL, etc. ). For this reason, the `docker stop` command does not cleanly shutdown HomeSeer. Instead, shutdown HomeSeer cleanly via Tools - System - Shutdown HomeSeer, which will also stop the container.

HomeSeer will be reinstalled anytime the container is deleted and re-created; when the container runs for the first time, you will see "`HomeSeer (re)install/update required at container first run. Installing at /HomeSeer...`" in the container log. However, your existing user data, plugins, etc., will not be affected. Subsequent container runs after the first will log "`HomeSeer already installed, not (re)installing/updating...`".

This image currently only runs on amd64/x86_64.

### Issues / Contributing

Please raise any issues with this container, including any missing plugin dependencies, at its GitHub repo: https://github.com/marthoc/docker-homeseer. Please check the "Gotchas / Known Issues" section above before raising an Issue on GitHub in case the issue is already known.

To contribute, please fork the GitHub repo, create a feature branch, and raise a Pull Request; for simple changes/fixes, it may be more effective to raise an Issue instead.

### Acknowledgments

Many improvements to this image have been made by @E1iTeDa357, including the addition of Avahi and dbus for wider plugin support, and converting the image to use s6-overlay.

### Changelog
18 January 2018: Initial release.  
19 January 2018: Added mono-devel.  
21 February 2018: Refactored latest, changed base image to mono:5.  
6 March 2019: Bumped to HS3 3.0.0.500; added Avahi and dbus; changed to s6-overlay; pinned Mono base image to prevent unintended breakage.  

