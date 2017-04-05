#!/bin/bash

# Everything in this file should be done via package management, not this script.  FIXME

# requires...
apt-get install qemu-kvm bridge-utils ovmf crudini arp-scan nmap

# install the unit template
mkdir -p /usr/lib/systemd/system
cp -v /srv/vmcore/systemd/vmcore-kvm@.service /usr/lib/systemd/system/
systemctl daemon-reload

# install the ovmf symlink
mkdir -p /srv/vmcore/ovmf
ln -sv /usr/share/ovmf/OVMF.fd /srv/vmcore/ovmf/bios.bin

# install the vmcore symlink
ln -sv /srv/vmcore/bin/vmcore /usr/bin/vmcore

# install the bash_complete file
cp bashcomplete /etc/bash_completion.d/vmcore
