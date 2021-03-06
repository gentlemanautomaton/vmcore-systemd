#!/bin/bash

if [ -n "$nic" ]; then
	# include br_netfilter kernel module (maybe shouldn't be automatic?)
	modprobe br_netfilter

	# turn up the nic
	/usr/bin/env ip link set dev $nic up

	# setup firewall chain for this nic
	/usr/bin/env iptables -w -N $nic
	/usr/bin/env iptables -w -F $nic

	# restrict to IP if defined
	if [ -n "$ip" ]; then
		OLDIFS="$IFS";IFS=" ,"
		for X in $ip; do
			/usr/bin/env iptables -w -A $nic -m physdev --physdev-is-bridged --physdev-in $nic -s $X -j RETURN
			/usr/bin/env iptables -w -A $nic -m physdev --physdev-is-bridged --physdev-out $nic -d $X -j RETURN
		done
		IFS="$OLDIFS"
		/usr/bin/env iptables -w -A $nic -j REJECT
	fi

	# load custom firewall if exists
	if [ -n "$firewall" -a -x "$firewall" ]; then
		. "$firewall"
	fi

	# attach chain for this nic to firewall
	/usr/bin/env iptables -w -A INPUT -m physdev --physdev-is-bridged --physdev-in $nic -j $nic
	/usr/bin/env iptables -w -A OUTPUT -m physdev --physdev-is-bridged --physdev-out $nic -j $nic
	/usr/bin/env iptables -w -A FORWARD -m physdev --physdev-is-bridged --physdev-in $nic -j $nic
	/usr/bin/env iptables -w -A FORWARD -m physdev --physdev-is-bridged --physdev-out $nic -j $nic

	# add nic to the bridge
	/usr/bin/env ip link set dev $nic master $bridge
fi
