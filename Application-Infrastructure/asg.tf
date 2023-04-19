resource "google_compute_instance_template" "instance_template" {
  name         = "instance-template"
  machine_type = "e2-medium"
  tags = ["http-server"]
  disk {
    source_image = "projects/alert-flames-286515/global/images/wordpress-image-1681867159"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "project-vpc"
    subnetwork = "app-subnet-1"
  }

  service_account {
    email  = "904016781596-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_group_manager" "instance_group" {
  name               = "managed-instance-group"
  zone               = "us-central1-a"
  base_instance_name = "managed-instance"

  target_pools = [google_compute_target_pool.target_pool.self_link]

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }

  version {
    instance_template = google_compute_instance_template.instance_template.self_link
  }
}

resource "google_compute_autoscaler" "autoscaler" {
  name = "autoscaler"
  zone = "us-central1-a"

  target = google_compute_instance_group_manager.instance_group.self_link

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_target_pool" "target_pool" {
  name = "target-pool"
  health_checks = [google_compute_http_health_check.http_health_check.self_link]
}

resource "google_compute_forwarding_rule" "http_forwarding_rule" {
  name        = "http-forwarding-rule"
  target      = google_compute_target_pool.target_pool.self_link
  port_range  = "80"
  ip_protocol = "TCP"
  ip_address  = google_compute_address.regional_ip.address
}

resource "google_compute_address" "regional_ip" {
  name   = "regional-ip"
  region = "us-central1"
}

resource "google_compute_http_health_check" "http_health_check" {
  name               = "http-health-check"
  request_path       = "/"
  check_interval_sec = 30
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 3
  port               = 80
}
