resource "google_compute_firewall" "allow-ssh" {
    
    name    = "${var.owner_name}-allow-ssh"
    network = google_compute_network.vpc_network.self_link

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
#    source_ranges = [ "72.47.39.106/32" ]
#    source_ranges = ["0.0.0.0/0"]
#    source_ranges = [ "${var.my_public_ip}" ]
    source_ranges = [ "${var.mypublicip_cidr}" ]
}

resource "google_compute_firewall" "allow-internal" {
    
    name    = "${var.owner_name}-allow-internal"
    network = google_compute_network.vpc_network.self_link

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "udp"
        ports    = ["0-65535"]
    }

    source_ranges = [
        google_compute_subnetwork.vpc_subnet.ip_cidr_range
    ]

}
