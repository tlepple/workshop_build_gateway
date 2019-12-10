#!/bin/bash

#########################################################
# Input parameters
#########################################################

case "$1" in
        aws)
           echo "you chose aws"
            ;;
        azure)
           echo "you chose azure"
            ;;
        gcp)
	   echo "you chose gcp"
            ;;
        *)
            echo $"Usage: $0 {aws|azure|gcp}"
            echo $"example: ./setup.sh azure"
            echo $"example: ./setup.sh aws"
            echo $"example: ./setup.sh gcp"
#            exit 0
esac

CLOUD_PROVIDER=$1

########################################################
# utility functions
#########################################################
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

starting_dir=`pwd`

# logging function
log() {
    echo -e "[$(date)] [$BASH_SOURCE: $BASH_LINENO] : $*"
    echo -e "[$(date)] [$BASH_SOURCE: $BASH_LINENO] : $*" >> $starting_dir/setup-all.log
}

#####################################################
# Execute cloud provider specific code
#####################################################

case "$CLOUD_PROVIDER" in
        aws)
            echo "execute aws code here... "
	  #  . /app/jumpboxMaster/provider/aws/aws_setup.sh
            ;;
        azure)
           echo "execute azure code here"
          #  . /app/jumpboxMaster/provider/azure/azure_setup.sh
            ;;
        gcp)
           echo "execute gcp code here..."
#             echo `pwd`
             cd ./provider/gcp
             . /app/workshop_build_gateway/provider/gcp/assemble.sh
            ;;
        *)
            echo "you had a different choice... is this block needed?"
	    ;;
esac

cd $starting_dir
