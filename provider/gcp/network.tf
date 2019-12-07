resource "google_compute_network" "vpc_network" {
  name                    = "${var.owner_name}-${var.network_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name                     = "${var.owner_name}-${var.subnet_name}"
  ip_cidr_range            = var.cidrs[0]
  network                  = google_compute_network.vpc_network.self_link
  region                   = var.region
  private_ip_google_access = true
}
