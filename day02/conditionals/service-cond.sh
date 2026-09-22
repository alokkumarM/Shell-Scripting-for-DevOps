#!/bin/bash

read -p "Enter the service name that status you want to check : " service

if systemctl is-active --quiet "$service"
then
	echo "$service is active "
else
	echo "$service is inactive"
fi

