# Cloud DNSは手動で設定
# resource "google_dns_managed_zone" "dev_root_dns_hello" {
#   name      = "butterthon-dev-jp"
#   dns_name  = "butterthon-dev.jp."
#   dnssec_config {
#     state = "on"
#   }
# }

resource "google_dns_record_set" "dev_record_about_me" {
  name = "dev-about-me.butterthon-dev.jp."
  type = "A"
  ttl  = 300

  managed_zone = "butterthon-dev-jp"
  rrdatas      = [google_compute_global_address.dev_static_ip_about_me.address]
}

resource "google_dns_record_set" "dev_record_about_me_api" {
  name = "dev-about-me-api.butterthon-dev.jp."
  type = "A"
  ttl  = 300

  managed_zone = "butterthon-dev-jp"
  rrdatas      = [google_compute_global_address.dev_static_ip_about_me_api.address]
}
