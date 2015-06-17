#!/bin/bash

if [ -n "$nic" ]; then
	# remove nic from the bridge
	/usr/bin/env brctl delif $bridge $nic

	# detach chain for this nic from firewall
	/usr/bin/env iptables -D INPUT -i $nic -j $nic
	/usr/bin/env iptables -D OUTPUT -o $nic -j $nic
	/usr/bin/env iptables -D FORWARD -i $nic -j $nic
	/usr/bin/env iptables -D FORWARD -o $nic -j $nic

	# remove firewall chain for this nic
	/usr/bin/env iptables -F $nic
	/usr/bin/env iptables -X $nic

	# turn down the nic
	/usr/bin/env ip link set $nic down
fi
