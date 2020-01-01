resource "google_compute_address" "static" {
    name = "${var.owner_name}-master-static-address"
}

resource "google_compute_disk" "cdsw_disk" {
    name = "${var.owner_name}-master-cdsw-disk"
    size = 100
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
    metadata     = {
                     ssh-keys = "${var.vm_ssh_user}:${file("/app/workshop_build_gateway${var.key_file_path}${var.public_key_name}")}" 
                   }
 
    boot_disk {
        initialize_params {
            image = var.vm_image_id
            size = 150
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
     metadata_startup_script = <<EOF
        echo "checking status of SElinux..."
        if [ getenforce != Disabled ]; then
            setenforce 0
            sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
            sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
        fi

        echo "disabling huge page support"
        if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
            echo never > /sys/kernel/mm/transparent_hugepage/enabled
        fi
        if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
            echo never > /sys/kernel/mm/transparent_hugepage/defrag
        fi

        # check for swappiness 
	echo "checking swappines..."
        if [ `cat /proc/sys/vm/swappiness` != 10 ]; then
            sysctl vm.swappiness=10
        fi

    EOF
    
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

output "instance_id" {
    value = "${google_compute_instance.master.instance_id}"
}

output "vm_elastic_ip" {
    value = "${google_compute_address.static.address}"
}

output "vm_private_ip" {
    value = "${google_compute_instance.master.network_interface.0.network_ip}"
}

output "vm_master_name" {
    value = "${var.owner_name}-${var.vm_master_name}"
}

output "project_name" {
    value = var.project
}

output "owner_name" {
    value = var.owner_name
}

output "region" {
    value = var.region
}

output "zone" {
    value = var.zone
}

