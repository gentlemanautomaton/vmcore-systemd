#!/bin/bash

if [ -n "$nic" ]; then
	# turn up the nic
	/usr/bin/env ip link set $nic up

	# setup firewall chain for this nic
	/usr/bin/env iptables -N $nic
	/usr/bin/env iptables -F $nic

	# restrict to IP if defined
	if [ -n "$ip" ]; then
		/usr/bin/env iptables -A $nic -i $nic ! -s $ip -j REJECT
		/usr/bin/env iptables -A $nic -o $nic ! -d $ip -j REJECT
	fi

	# load custom firewall if exists
	if [ -n "$firewall" -a -x "$firewall" ]; then
		. "$firewall"
	fi

	# attach chain for this nic to firewall
	/usr/bin/env iptables -A INPUT -i $nic -j $nic
	/usr/bin/env iptables -A OUTPUT -o $nic -j $nic
	/usr/bin/env iptables -A FORWARD -i $nic -j $nic
	/usr/bin/env iptables -A FORWARD -o $nic -j $nic

	# add nic to the bridge
	/usr/bin/env brctl addif $bridge $nic
fi
