#!/bin/bash

echo "----------DEPLOYING AND ERROR HANDLING OF DJANGO APP--------"

# FUNCTION FOR THE CLONING THE DJANGO APP REPO

clone() {
	echo "---CLONING DJANGO APP---"
	if [[ -d "django-notes-app" ]]; then
		
		if [[ ! -d "django-notes-app/.git" ]]; then
			echo "FAILED DIR. EXIST BUT NOT GIT REPO"
			return 1
		fi
		echo "CODE REPO ALREADY EXIST USING IT"


	else
		git clone https://github.com/alokkumarM/django-notes-app.git || {
			echo "FAILED CLONE"
			return 1
		}
	fi

	cd django-notes-app || {
	
		echo "FAILED TO ENTER IN APP DIR."
		return 1
	}
	echo "CODE REPO IS READY"
}

# FUNCTION TO INSTALL REQUIREMENTS

depend() {
	echo "INSTALLING REQUIRED DEPENDENCIES"
	sudo apt update && sudo apt install docker.io docker-compose -y || {
		echo "Failed to install requirements"
		return 1
	}
}

# FUNCTION TO ENABLE AND START SERVICES AND ADD USER TO DOCKER GROUP

service() {
	echo "PERFORMING SERVICES SETUP AND ADDING USER IN DOCKER GROUP"
	#ENABLING DOCKER
	sudo systemctl enable docker || {
		echo "FAILEDIN ENABLING DOCKER"
		return 1
	}

	# STARTING DOCKER 
	sudo systemctl start docker || {
		echo "FAILED IN TARTING DOCKER"
		return 1
	}

	# ADDING USER TO GROUP
	sudo usermod -aG docker "$USER" || {
		echo "FAILED IN ADDING USER IN DOCKER GROUP"
		return 1
	}

}

# FUNCTION FOR BUILDING AND DEPLOYING APP

deploy() {
	echo "BUILDING AND DEPLOYING APP"
	sudo docker build -t notes-app . && sudo docker compose up -d || {
		echo "FAILED BUILD AND DEPLOYMENT"
		return 1
	}

}

# NOW MAIN DEPLOYEMENT SCRIPT 

echo "-----DEPLOYMENT STARTED--------------------"

# CLONE THE CODE
if ! clone; then
	exit 1
fi

# INSTALL DEPENDENCIES
if ! depend; then
	exit 1
fi

# SETUPING THE SERVICES ADDING USER IN DOCKER GROUP
if ! service; then
	exit 1
fi

# DEPLOYING AND BUILDING APP
if ! deploy; then
	exit 1

fi 

echo "----DEPLOYMENT SUCCESSFULLY DONE-----------"

