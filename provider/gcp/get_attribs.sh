#!/bin/bash

###########################################################################################################
# import parameters and utility functions 
###########################################################################################################
. $starting_dir/provider/gcp/.env.template

ASSEMBLE_JSON=`cat ${starting_dir:?}/provider/gcp/assemble_output.json`

export LV_VM_MASTER_NAME=`echo $ASSEMBLE_JSON |jq -r ".vm_master_name.value"`
export LV_VM_PRIVATE_IP=`echo $ASSEMBLE_JSON |jq -r ".vm_private_ip.value"`
export LV_VM_PUBLIC_IP=`echo $ASSEMBLE_JSON |jq -r ".vm_elastic_ip.value"`
export LV_VM_INSTANCE_ID=`echo $ASSEMBLE_JSON |jq -r ".instance_id.value"`
export LV_OWNER=`echo $ASSEMBLE_JSON |jq -r ".owner_name.value"`
export LV_PROJECT_NAME=`echo $ASSEMBLE_JSON |jq -r ".project_name.value"`
export LV_REGION=`echo $ASSEMBLE_JSON |jq -r ".region.value"`
export LV_ZONE=`echo $ASSEMBLE_JSON |jq -r ".zone.value"`
export LV_BIND_FILENAME="${LV_OWNER}-${LV_ZONE}-${LV_VM_INSTANCE_ID}-${LV_VM_PRIVATE_IP}.pem"

export LV_VM_CDPDC_PUBLIC_IP=`echo $ASSEMBLE_JSON |jq -r ".vm_cdpdc_elastic_ip.value"`
export LV_VM_CDPDC_NAME=`echo $ASSEMBLE_JSON |jq -r ".vm_cdpdc_name.value"`
export LV_VM_CDPDC_INSTANCE_ID=`echo $ASSEMBLE_JSON |jq -r ".cdpdc_instance_id.value"`
export LV_VM_CDPDC_PRIVATE_IP=`echo $ASSEMBLE_JSON |jq -r ".vm_cdpdc_private_ip.value"`
