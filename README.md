# workshop_build_gateway
---

Notes:
---
*  This was built and tested on Docker Version 19.03.5
*  This assumes you already have Docker installed.
*  It was tested on MacOS
*  It was tested and run using Terraform v0.12.17 

## Docker setup steps
---

```
# Pull docker image centos 7
docker pull centos:7

# Create a docker volume to persist data
docker volume create terraform-vol1

# inspect volume
docker volume inspect terraform-vol1

# list volumes
docker volume ls

# create a directory in OS for bind mount:
cd ~
mkdir -p ./Documents/aws_scripts/docker_bind_mnt

# create a softlink to this directory
sudo ln -s /Users/$USER/Documents/aws_scripts/docker_bind_mnt /macmnt

# run a new docker container with this volume from centos image

 docker run -it \
  --name centos_terraform \
  --mount source=terraform-vol1,target=/app \
  --mount type=bind,source=/Users/$USER/Documents/aws_scripts/docker_bind_mnt,target=/macmnt \
  centos:7 bash
  
```


---
## Pull git repo into this new container to build out instnace

```
#install git
yum install -y git
cd /app
git clone https://github.com/tlepple/workshop_build_gateway.git
cd /app/workshop_build_gateway
```

###  Setup GCP Service Account:

1.  Create new service account [here](https://console.cloud.google.com/iam-admin/serviceaccounts)
2.  Select your project name.  `Example: 'gcp-se'`
3.  Click the '+ CREATE SERVICE ACCOUNT' link at top of console.
4.  Give a value to the text box `Service account name`.   Example: `tlepple`
5.  Make no changes to the text box `Service account ID`
6.  Give a description.  Example `tlepple terraform sa`
7.  Click the `CREATE` button.
8.  In the next screen do not select a role but do click the `CONTINUE` button.
9.  In this screen, leave everything as the default but do click the `+ CREATE KEY` button.
10. In the pop-up screen choose a 'key type' of `JSON` and click the `CREATE` button.
11. This will prompt your computer to save a new private key file.  Take note of the file name and location.   Example `gcp-se-2f3b1195299c.json`

*  This new key file will be used later to provision your GCP resources from within `TERRAFORM`
