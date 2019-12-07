#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd -L)

# get the public ip address of this host
GET_PUBLIC_IP=`curl -s ifconfig.me`

# set the public ip cidr as a variable
export TF_VAR_mypublicip_cidr="${GET_PUBLIC_IP}/32"

#echo ${TF_VAR_mypublicip_cidr}

#  call the terraform build
terraform apply -var-file var-properties.tfvars
