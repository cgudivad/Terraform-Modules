resource "google_compute_instance" "default" {
  project      = var.project
  count        = var.vmcount
  name         = "${var.vmname}${count.index}"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = var.vpcnetworkname
    subnetwork = var.subnetworkname
    subnetwork_project = var.project
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    startup-script = <<SCRIPT

	    #!/usr/bin/env bash
	    sudo apt update && sudo apt install mariadb-client-10.5 -y

    SCRIPT

  }
}
