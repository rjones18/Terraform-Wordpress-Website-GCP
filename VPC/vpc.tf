resource "google_compute_network" "vpc_network" {
  name                    = "project-vpc"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "web-subnet-1" {
  name          = "web-subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.self_link
  private_ip_google_access = false
}


resource "google_compute_subnetwork" "app-subnet-1" {
  name          = "app-subnet-1"
  ip_cidr_range = "10.0.10.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
}

resource "google_compute_firewall" "web_firewall" {
  name    = "web-firewall"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "app_firewall" {
  name    = "app-firewall"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [ "0.0.0.0/0" ]
  target_tags = ["app"]
}


resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_service_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_router" "router" {
  name    = "nat-router"
  network = "project-vpc"
  region  = "us-central1"
}

resource "google_compute_router_nat" "nat" {
  name   = "nat-gateway"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}