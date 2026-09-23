#!/bin/bash

echo "------now going to check service status by while and passing argument as a service name-------------------------"

while systemctl is-active --quiet "$1"
do
	echo "$1 is avtive"
	sleep 5
done

echo "$1 is inactive"
