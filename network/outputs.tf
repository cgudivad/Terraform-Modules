output "vpcnetworkname" {
	value = google_compute_network.vpc_network.name
}

output "vpcnetworkid" {
	value = google_compute_network.vpc_network.id
}

output "subnetworkname" {
        value = google_compute_subnetwork.test_subnetwork.name
}
