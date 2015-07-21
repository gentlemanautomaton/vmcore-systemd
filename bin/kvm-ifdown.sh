#!/bin/bash

if [ -n "$nic" ]; then
	# remove nic from the bridge
	/usr/bin/env brctl delif $bridge $nic

	# detach chain for this nic from firewall
        /usr/bin/env iptables -w -D INPUT -m physdev --physdev-is-bridged --physdev-in $nic -j $nic
        /usr/bin/env iptables -w -D OUTPUT -m physdev --physdev-is-bridged --physdev-out $nic -j $nic
        /usr/bin/env iptables -w -D FORWARD -m physdev --physdev-is-bridged --physdev-in $nic -j $nic
        /usr/bin/env iptables -w -D FORWARD -m physdev --physdev-is-bridged --physdev-out $nic -j $nic

	# remove firewall chain for this nic
	/usr/bin/env iptables -w -F $nic
	/usr/bin/env iptables -w -X $nic

	# turn down the nic
	/usr/bin/env ip link set $nic down
fi
