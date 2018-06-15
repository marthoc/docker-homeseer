#!/bin/sh

if [ -e /DO_INSTALL ]
then
    echo "HomeSeer (re)install/update required at container first run. Installing at /HomeSeer..."

    wget -O /homeseer.tgz "http://homeseer.com/updates3/hs3_linux_$HOMESEER_VERSION.tar.gz"
    tar -xzo -C / -f /homeseer.tgz
    rm -f /homeseer.tgz
    rm -f /DO_INSTALL

else
    echo "HomeSeer already installed, not (re)installing/updating..."

fi

if [ "$ZEROCONF_ENABLED" = "TRUE" ]
then 
    service dbus start
    service avahi-daemon start
fi

mono /HomeSeer/HSConsole.exe --log
