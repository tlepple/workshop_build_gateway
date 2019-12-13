variable "project" {
    description = "GCP Project ID"
}

variable "owner_name" {
    description = "Owner name of resources"
}

variable "credentials_file" { }

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

#variable "tag_vals" { 
#    type = map
#    default = {
#      "owner" = "tlepple"
#      "project" = "personal development"
#      "enddate" = "permanent"
#    }
#}

variable "network_name" {
    description = "GCP VPC Network Name"
}

variable "subnet_name" {
    description = "GCP Subnet Name"
}

variable "cidrs" {
    description = "Subnet IP Range" 
    type = list
}

variable "vm_master_name" {
    description = "VM Instance Master Name"
}

variable "vm_instance_type" {
    description = "VM Instance Type"
}

variable "vm_ssh_user" {
    description = "VM SSH User Name"
}

variable "vm_image_id" {
    description = "Image ID"
}

variable "my_publicip" {
    description = "Public IP Address of machine that built the instance"
}

#variable "mypublicip_cidr" {
#     description = "Public IP Address cidr to set for access from build host"
#}

variable "private_key_name" {
      description ="Private SSH Key Filename"
}

variable "public_key_name" {
      description ="Public SSH Key Filename"
}

variable "key_file_path" {
      description = "SSH Key file path"
}

variable "cloud_username" {
      description = "cloud provider user name"
}
