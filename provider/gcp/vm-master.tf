resource "google_compute_address" "static" {
    name = "${var.owner_name}-master-static-address"
}

resource "google_compute_disk" "cdsw_disk" {
    name = "${var.owner_name}-master-cdsw-disk"
    size = 10
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

    attached_disk {
        source = google_compute_disk.cdsw_disk.name
    }

    network_interface {
        network            = google_compute_network.vpc_network.name
        subnetwork         = google_compute_subnetwork.vpc_subnet.name
        access_config {
            nat_ip = google_compute_address.static.address
        }
    }
    

}
