resource "google_compute_global_address" "private_ip_address" {

  name          = var.privateipname
  project       = var.project
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpcnetworkid

}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = var.vpcnetworkid
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

}
