#!/bin/bash

# Now simply doing handson with argumnets in shell scripting

echo "-------Now simply i am going to do handson with args in shell scripting---------"

echo "Script name : $0"
echo "First argument : $1"
echo "Second argument : $2"
echo "Total arguments : $#"
echo "All arguments : $@"

# Now going to create user in linux using argument


echo "Now i write a script to create a user by passing arguments "
echo "Creating user with name : $1"
sudo useradd -m $1

# Now goint to create multiple users

echo "------Now i am writing a simple script to create a multiple user using args by for loop-------------"

for i in "$@"
do 
	echo "creating $i user"
	sudo useradd -m $i
	echo "User $i is created"

done
echo "Now you can see all the user created at the bottom lines i.e 
$(cat /etc/passwd)"
