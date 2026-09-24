#!/bin/bash

echo "------------------Creating user by function by passing function args multiple calling----------------------------"

user-create() {
	sudo useradd -m "$1"
	echo "$1 user is created"
}

user-create "dev1"
user-create "deb2"
user-create dev3



echo "-------------------now creating users by uding function and loop and args by script args----------------------"

user() {
	sudo useradd -m  "$1"
	echo "$1 user is created"
}
user

for i in "$@"
do
	user "$i"
done

echo "$(cat /etc/passwd)"
