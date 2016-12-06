#!/bin/bash

# Everything in this file should be done via package management, not this script.  FIXME

# requires...
apt-get install qemu-kvm bridge-utils crudini arp-scan nmap

# install the unit template
mkdir -p /usr/lib/systemd/system
cp -v /srv/vmcore/systemd/vmcore-kvm@.service /usr/lib/systemd/system/
systemctl daemon-reload

# install the vmcore symlink
ln -sv /srv/vmcore/bin/vmcore /usr/bin/vmcore

# install the bash_complete file
cp bashcomplete /etc/bash_completion.d/vmcore
