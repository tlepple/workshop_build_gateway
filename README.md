# workshop_build_gateway
---

Notes:
---
*  This was built and tested on Docker Version 19.03.5
*  This assumes you already have Docker installed.

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
---
### Cloud Provider Specific Steps:
---

| ---------------- | ---------------- |
| Provider | Readme Document |
| ---------------- | ---------------- |
| GCP | [Setup Steps](./gcp_readme.md)
| ---------------- | ---------------- |

