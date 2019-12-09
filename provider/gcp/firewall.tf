resource "google_compute_firewall" "allow-ssh" {
    
    name    = "${var.owner_name}-allow-ssh"
    network = google_compute_network.vpc_network.self_link

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
#    source_ranges = [ "${var.mypublicip_cidr}" ]
    source_ranges = [ "0.0.0.0/0" ]
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

resource "google_compute_firewall" "allow-remote-static" {

    name    = "${var.owner_name}-allow-remote-static"
    network = google_compute_network.vpc_network.self_link

    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    source_ranges = [ "${var.mypublicip_cidr}" ]
}
