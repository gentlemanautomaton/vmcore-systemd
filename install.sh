#!/bin/bash

# Everything in this file should be done via package management, not this script.  FIXME

# requires...
apt-get install qemu-kvm ovmf crudini

# install the unit template
mkdir -p /usr/lib/systemd/system
cp -v /srv/vmcore/systemd/vmcore-kvm-v1@.service /usr/lib/systemd/system/
cp -v /srv/vmcore/systemd/vmcore-kvm-v2@.service /usr/lib/systemd/system/
systemctl daemon-reload

# install the stable ovmf symlink
mkdir -p /srv/vmcore/ovmf
ln -sv /usr/share/ovmf/OVMF.fd /srv/vmcore/ovmf/stable.bin

# TODO: install the latest ovmf symlink

# install the vmcore symlink
ln -sv /srv/vmcore/bin/vmcore /usr/bin/vmcore

# install the bash_complete file
cp bashcomplete /etc/bash_completion.d/vmcore
