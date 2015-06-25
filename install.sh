#!/bin/bash

# Everything in this file should be done via package management, not this script.  FIXME

# requires...
apt-get install qemu-kvm bridge-utils

# install the unit template
mkdir -p /usr/lib/systemd/system
cp -v /srv/vmcore/systemd/vmcore-kvm@.service /usr/lib/systemd/system/
systemctl daemon-reload

# install the vmcore symlink
ln -sv /srv/vmcore/bin/vmcore /usr/sbin/vmcore
