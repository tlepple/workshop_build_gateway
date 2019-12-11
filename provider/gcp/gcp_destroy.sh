#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd -L)


#  call the terraform destroy
log "Destroy GCP env build via Terraform"
terraform destroy -var-file var-properties.tfvars
