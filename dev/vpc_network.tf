// プライベートネットワーク
resource "google_compute_network" "dev_private_network_about_me" {
  provider = google-beta

  name = "dev-private-network-about-me"
}

// プライベートIPアドレス
resource "google_compute_global_address" "dev_private_ip_about_me" {
  provider = google-beta

  name          = "dev-private-ip-about-me"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.dev_private_network_about_me.id
}

// プライベートVPCコネクション
resource "google_service_networking_connection" "dev_private_vpc_conn_about_me" {
  provider = google-beta

  network                 = google_compute_network.dev_private_network_about_me.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.dev_private_ip_about_me.name]
}

// 予約IPアドレス
resource "google_compute_global_address" "dev_static_ip_about_me" {
  name = "dev-static-ip-about-me"
}
resource "google_compute_global_address" "dev_static_ip_about_me_api" {
  name = "dev-static-ip-about-me-api"
}
