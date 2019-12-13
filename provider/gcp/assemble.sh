#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd -L)

# get the public ip address of this host
GET_PUBLIC_IP=`curl -s ifconfig.me`

# set the public ip as a variable
export TF_VAR_my_publicip="${GET_PUBLIC_IP}"

#  call the terraform build
log "Build out GCP env via Terraform"
terraform apply -var-file var-properties.tfvars

# write terraform output to a json file:
terraform output -json > $starting_dir/provider/gcp/assemble_output.json
