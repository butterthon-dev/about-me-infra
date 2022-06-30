// Google管理の証明書
resource "google_compute_managed_ssl_certificate" "dev_ssl_about_me" {
  name = "dev-ssl-about-me"

  managed {
    domains = ["dev-about-me.butterthon-dev.jp"]
  }
}

// LB - バックエンドの構成
resource "google_compute_backend_bucket" "dev_backend_bucket_about_me" {
  name          = "dev-backend-bucket-about-me"
  bucket_name   = module.cloud_storage.bucket_name
  enable_cdn    = true

  edge_security_policy = module.cloud_armor.cloud_armor_id
}

// HTTP/HTTPS ロードバランサ
resource "google_compute_url_map" "dev_lb_about_me" {
  name              = "dev-lb-about-me"
  default_service   = google_compute_backend_bucket.dev_backend_bucket_about_me.id
}

// HTTPSプロキシ
resource "google_compute_target_https_proxy" "dev_https_pxy_about_me" {
  name              = "dev-https-pxy-about-me"
  url_map           = google_compute_url_map.dev_lb_about_me.id
  ssl_certificates  = [google_compute_managed_ssl_certificate.dev_ssl_about_me.id]
}

// LB - フロントエンドの構成
// 証明書のステータスが"ACTIVE"になるまでフロントにアクセスできない。
resource "google_compute_global_forwarding_rule" "dev_fw_about_me" {
  name          = "dev-fw-about-me"
  target        = google_compute_target_https_proxy.dev_https_pxy_about_me.id
  port_range    = "443" // targetにhttps-proxyを指定する場合はこの指定が必要

  # load_balancing_scheme = "EXTERNAL" // デフォルトがEXTERNAL
  ip_address    = google_compute_global_address.dev_static_ip_about_me.id
}

// IP制限
module "cloud_armor" {
  source = "../modules/cloud_armor"

  policy_name       = "dev-armor-about-me"
  type              = "CLOUD_ARMOR_EDGE"
  deny_ip_ranges    = var.deny_ip_ranges
  allow_ip_ranges   = var.allow_ip_ranges
}
