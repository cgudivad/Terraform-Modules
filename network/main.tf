resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.vpcnetworkname
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "test_subnetwork" {
  project       = var.project
  name          = var.subnetworkname
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = var.CIDR
  region        = var.region
}

resource "google_compute_firewall" "rules" {
  project     = var.project
  name        = var.firewallname
  network     = google_compute_network.vpc_network.name
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["web-server"]
}

