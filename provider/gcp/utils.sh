#!/bin/bash

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

#####################################################
# Function to create ssh key pair
#####################################################
create_key_pair() {

#ssh-keygen -t rsa -b 2048 -C ${TF_VAR_cloud_username:?} -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_key_filename:?} -q -P ""
#  chmod 0400 ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_key_filename:?} 
	
	if [ -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?} ]; then
	  log "Key already exists: ${TF_VAR_private_key_name:?}.  Will reuse it."
	else
	  log "Creating the ssh key pair files..."
	  mkdir -p ${starting_dir:?}${TF_VAR_key_file_path:?}
	  umask 0277
          ssh-keygen -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?} -N "" -m PEM -t rsa -b 2048 -C ${TF_VAR_vm_ssh_user:?}
	  chmod 0400 ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?}
	  umask 0022 
	  log "Private key created: ${TF_VAR_private_key_name:?}"
	fi
}

#####################################################
# Function to  archive ssh key pair
#####################################################
archive_key_pair() {
	if [ -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?} ]; then
	  log "Archiving key pair [${TF_VAR_private_key_name:?}]"
	  mv -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?} ${starting_dir:?}${TF_VAR_key_file_path:?}.${TF_VAR_private_key_name:?}.OLD.$(date +%s)
	  mv -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_public_key_name:?} ${starting_dir:?}${TF_VAR_key_file_path:?}.${TF_VAR_public_key_name:?}.OLD.$(date +%s)
	fi
}

#####################################################
# Function to  archive assemble_output.json
#####################################################
archive_assemble_json() {
	if [ -f ${starting_dir:?}/provider/gcp/assemble_output.json ]; then
	   mv -f ${starting_dir:?}/provider/gcp/assemble_output.json ${starting_dir:?}/provider/gcp/archive/.assemble_output.json.OLD.$(date +%s)
	fi
}

#####################################################
# Function to copy key file to a bind mount
#####################################################
replicate_key() {
	if [ -f ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?} ]; then
	    #  call some attribs variables
            . $starting_dir/provider/gcp/get_attribs.sh
	    cp ${starting_dir:?}${TF_VAR_key_file_path:?}${TF_VAR_private_key_name:?} ${BIND_MNT_TARGET}/${LV_BIND_FILENAME}
	fi
}

#####################################################
# Function to delete bind key
#####################################################
delete_bind_key() {
	rm -f ${BIND_MNT_TARGET}/${LV_BIND_FILENAME}
}

#####################################################
# Function to install gcloud cli
#####################################################
install_gcp_cli() {
	log "Installing gcloud sdk..."
	gcp_cli_version=`gcloud --version 2>&1`
	log "Current gcloud version: $gcp_cli_version"
	if [[ $gcp_cli_version = *"Google Cloud SDK"* ]]; then
	    log "gcloud cli already installed.  Skipping"
	    return
	fi
	yum install -y wget
	wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-273.0.0-linux-x86_64.tar.gz -P /tmp
	tar -xf /tmp/google-cloud-sdk-273.0.0-linux-x86_64.tar.gz -C /usr/local/bin
	echo "	" >> ~/.bashrc
	echo "# The next line updates PATH for the Google Cloud SDK." >> ~/.bashrc
	echo "if [ -f '/usr/local/bin/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/bin/google-cloud-sdk/path.bash.inc'; fi" >> ~/.bashrc	
	# initialize bash profile to see this add:
	. ~/.bash_profile
	# remove the dowloaded tmp file
	rm -f /tmp/google-cloud-sdk-273.0.0-linux-x86_64.tar.gz
	# activate the service account
	gcloud auth activate-service-account --key-file "$starting_dir/provider/gcp/keygcp.json"
	log "Done installing gcloud cli"
	
}
