#!/bin/bash

<< comment 
HI THIS A FILE IN WHICH I LEARN AND DO HANDS-ON OF VARIBLE
UNDERSTANDING AND ALSO IMPLEMENTING MULTILINE COMMENTS USING
BLOCK NAME HERE COMMENT AND IN THIS FILE I ASSIGN VALUE TO 
VARIABLE AND GET OUTPUT VIA ECHO. AND ALSO TAKING USER INPUT
ALSO FOR THE VARIABLE AND EXECUTING SOME COMMANDS OF LINUX ALSO
LIKE DATE AND VIEWING USERS CAT /ETC/PASSWD ETC
comment

# assigning values to variable

echo "-----------Assigning value to variable then printing-----------------" 

name="ALOK"
course="DEVOPS"

# printing output

echo "My name is : $name"
echo "I am learning $course and date is: $(date)"

# Now taking user input for variables

echo "------------Now taking user input and with also (-p) i.e promt for read & then printing-----------------"

echo "Enter your name : "
read name

read -p "enter your course name " course
echo "Hi $name your course name is $course "

# Now for creating the user with above user value and also verifying by listing user by command cat /etc/passwd

echo "------------------now creating user with above user variable value(VALUE MUST BE IN SMALL FOR CREATING USER) and listing bu cat /etc/passwd--------------------------"

sudo useradd -m $name

echo "Now one new user is created with use name $name and see it at bottom of user list 
  $(cat /etc/passwd)"
