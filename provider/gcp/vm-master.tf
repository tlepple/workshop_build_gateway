resource "google_compute_address" "static" {
    name = "${var.owner_name}-master-static-address"
}

resource "google_compute_instance" "master" {
    name         = "${var.owner_name}-${var.vm_master_name}"
    machine_type = var.vm_instance_type
    tags = ["master"]
    
    boot_disk {
        initialize_params {
            image = var.vm_image_id
            size = 20
        }
    }

    network_interface {
        network            = google_compute_network.vpc_network.name
        subnetwork         = google_compute_subnetwork.vpc_subnet.name
        access_config {
            nat_ip = google_compute_address.static.address
        }
    }
    
#    service_account {
#        email              = "tlepple@gcp-se.iam.gserviceaccount.com"
#        scopes             = [ "https://www.googleapis.com/auth/cloud-platform" ]
#    }

}
