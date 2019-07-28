#!/bin/bash

# Check network status
#NETSTAT="netstat -an -f inet -p tcp | grep LISTEN"
NETSTAT="netstat -an | grep LISTEN"
echo "NETSTAT: ${NETSTAT}"
echo "----------------------------------------"
eval $NETSTAT


DSCACHEUTIL="dscacheutil -q host -a name localhost."
echo "DSCACHEUTIL: ${DSCACHEUTIL}"
echo "----------------------------------------"
eval $DSCACHEUTIL


SCUTIL="scutil --dns"
echo "SCUTIL: ${SCUTIL}"
echo "----------------------------------------"
eval $SCUTIL
