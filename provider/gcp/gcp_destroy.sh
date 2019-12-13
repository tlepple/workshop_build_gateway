#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd -L)

###########################################################################################################
# import parameters and utility functions 
###########################################################################################################
. $starting_dir/provider/gcp/utils.sh
. $starting_dir/provider/gcp/.env

#  call the terraform destroy
log "Destroy GCP env build via Terraform"
terraform destroy -var-file var-properties.tfvars

# call function to archive ssh key pair
archive_key_pair

# call the function to archive the assemble json file
archive_assemble_json
