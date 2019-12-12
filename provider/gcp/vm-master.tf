resource "google_compute_address" "static" {
    name = "${var.owner_name}-master-static-address"
}

resource "google_compute_disk" "cdsw_disk" {
    name = "${var.owner_name}-master-cdsw-disk"
    size = 20
}

resource "google_compute_instance" "master" {
    name         = "${var.owner_name}-${var.vm_master_name}"
    machine_type = var.vm_instance_type
    tags         = ["master"]
    labels       = { 
                     "owner" = var.owner_name 
                     "project" = "personal_development"
                     "enddate" = "permanent"
                   }
 
    boot_disk {
        initialize_params {
            image = var.vm_image_id
            size = 15
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

resource "google_compute_firewall" "allow-host-publicip" {

    name    = "${var.owner_name}-allow-host-publicip"
    network = google_compute_network.vpc_network.self_link

    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    source_ranges = [ google_compute_address.static.address ]
}
