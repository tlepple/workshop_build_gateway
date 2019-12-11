#!/bin/bash

###########################################################################################################
# Define Functions:
###########################################################################################################

#####################################################
# Function to install aws cli
#####################################################
install_jq_cli() {

	#####################################################
	# first check if JQ is installed
	#####################################################
	log "Installing jq"

	jq_v=`jq --version 2>&1`
	if [[ $jq_v = *"command not found"* ]]; then
	  curl -L -s -o jq "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
	  chmod +x ./jq
	  cp jq /usr/bin
	else
	  log "jq already installed. Skipping"
	fi

	jq_v=`jq --version 2>&1`
	if [[ $jq_v = *"command not found"* ]]; then
	  log "error installing jq. Please see README and install manually"
	  echo "Error installing jq. Please see README and install manually"
	  exit 1 
	fi  

}

#####################################################
# Function to install terraform cli
#####################################################
install_terraform_cli() {
	log "Installing TERRAFORM_CLI"
	terraform_cli_version=`terraform --version 2>&1`
	log "Current Terraform CLi version: $terraform_cli_version"
	if [[ $terraform_cli_version = *"Terraform v"* ]]; then
	    log "Terraform CLI already installed.  Skipping"
	    return
	else
	    yum install -y unzip wget
	    wget https://releases.hashicorp.com/terraform/0.12.17/terraform_0.12.17_linux_amd64.zip
	    unzip terraform_0.12.17_linux_amd64.zip -d /usr/bin
	    rm -rf terraform_0.12.17_linux_amd64.zip
	fi
	log "Done installing Terraform CLI"

}
