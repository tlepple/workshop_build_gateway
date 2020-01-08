#!/bin/bash

###########################################################################################################
# import parameters and utility functions 
###########################################################################################################
. $starting_dir/provider/gcp/utils.sh
. $starting_dir/provider/gcp/.env.template



RUN_STATE=`gcloud compute instances describe $LV_VM_MASTER_NAME --zone=$LV_ZONE --project $LV_PROJECT_NAME --format="json"| jq -r ".status"`

echo "Current run state is: " ${RUN_STATE}

if [ ${RUN_STATE} == "RUNNING" ]; then
    gcloud compute instances stop ${LV_VM_MASTER_NAME} --zone=${LV_ZONE} --project ${LV_PROJECT_NAME}
    gcloud compute instances stop ${LV_VM_CDPDC_NAME} --zone=${LV_ZONE} --project ${LV_PROJECT_NAME}
    echo
else
    echo "Instance " ${LV_VM_MASTER_NAME} " is in a different state: " ${RUN_STATE}
fi

