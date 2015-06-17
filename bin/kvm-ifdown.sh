#!/bin/bash

date >> /tmp/kvm-ifdown.$$.log
echo $* >> /tmp/kvm-ifdown.$$.log
env >> /tmp/kvm-ifdown.$$.log
