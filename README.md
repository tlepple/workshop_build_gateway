# workshop_build_gateway
---

Notes:
---
*  This was built and tested on Docker Version 19.03.5
*  This assumes you already have Docker installed.
*  Currently only supports builds in GCP

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
mkdir -p ./Documents/terraform_stuff/docker_bind_mnt

# create a softlink to this directory
sudo ln -s /Users/$USER/Documents/terraform_stuff/docker_bind_mnt /dockmnt

# run a new docker container with this volume from centos image

 docker run -it \
  --name centos_terraform \
  --mount source=terraform-vol1,target=/app \
  --mount type=bind,source=/Users/$USER/Documents/terraform_stuff/docker_bind_mnt,target=/dockmnt \
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
---
### Cloud Provider Specific Setup / Terminate Steps:
---

| Provider         | Readme Document  |
| ---------------- | ---------------- |
| GCP              | [Setup Steps](./gcp_readme.md)|
| GCP              | [Terminate Steps](./terminate_readme.md)|

---

###  Start / Stop an existing instance with a provider:

---

```
# Example Start:  
cd /app/workshop_build_gateway
. bin/start_instance.sh <aws | azure | gcp>

# Example Stop:  
cd /app/workshop_build_gateway
. bin/stop_instance.sh <aws | azure | gcp>
```

---
---

# Usefull docker command reference:

---

```
# list all containers on host
---------------------------------------------
docker ps -a

#  start an existing container
---------------------------------------------
docker start centos_terraform

# connect to command line of this container
---------------------------------------------
docker exec -it centos_terraform bash

#list running container
---------------------------------------------
docker container ls -all

# stop a running container
---------------------------------------------
docker container stop centos_terraform

# remove a docker container
---------------------------------------------
docker container rm centos_terraform

# list docker volumes
---------------------------------------------
docker volume ls

# remove a docker volume
---------------------------------------------
docker volume rm terraform-vol1


```

---
