#!/bin/bash

###########################################################################################################
# import parameters and utility functions 
###########################################################################################################
. $starting_dir/provider/gcp/utils.sh
. $starting_dir/provider/gcp/.env.template

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

starting_dir=`pwd`

# logging function
log() {
    echo -e "[$(date)] [$BASH_SOURCE: $BASH_LINENO] : $*"
}

RUN_STATE=`gcloud compute instances describe $LV_VM_MASTER_NAME --zone=$LV_ZONE --project $LV_PROJECT_NAME --format="json"| jq -r ".status"`

echo "Current run state is: " ${RUN_STATE}

if [ ${RUN_STATE} == "TERMINATED" ]; then
    gcloud compute instances start ${LV_VM_MASTER_NAME} --zone=${LV_ZONE} --project ${LV_PROJECT_NAME}
    #  call the connection strings script:
    echo
    echo
    . ${starting_dir}/provider/gcp/echo_conn_strings.sh
else
    echo "Instance " ${LV_VM_MASTER_NAME} " is in a different state: " ${RUN_STATE}
fi

