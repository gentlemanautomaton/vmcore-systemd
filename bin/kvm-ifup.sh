#!/bin/bash

date >> /tmp/kvm-ifup.$$.log
echo $* >> /tmp/kvm-ifup.$$.log
env >> /tmp/kvm-ifup.$$.log
