#!/bin/bash

###########################################################################################################
# import parameters and utility functions 
###########################################################################################################
. $starting_dir/provider/gcp/utils.sh
. $starting_dir/provider/gcp/.env


#####################################################
#	Step 1: install the JQ cli
#####################################################
install_jq_cli

#####################################################
#       Step 2: install the Terraform cli
#####################################################
install_terraform_cli

#####################################################
#       Step 3: create an ssh key pair
#####################################################
create_key_pair

#####################################################
#       Step 4: build out GCP env
#####################################################
. $starting_dir/provider/gcp/assemble.sh

#####################################################
#       Step 5: replicate key to bind mnt
#####################################################
replicate_key

#####################################################
#      print connection strings 
#####################################################
. $starting_dir/provider/gcp/echo_conn_strings.sh
