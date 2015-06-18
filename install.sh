#!/bin/bash

# install the unit template (this is where it should go if we deployed this as a package)
cp -v /srv/vmcore/systemd/vmcore-kvm@.service /usr/lib/systemd/system/
systemctl daemon-reload
