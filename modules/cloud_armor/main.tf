// IP制限（Cloud Armor）
// v4.24.0のドキュメント通りに書くとハマる（https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy）
// action deny(403)のpriorityは2147483647(最低)にし、src_ip_rangesを["*"]にする。
resource "google_compute_security_policy" "armor_about_me" {
  name = var.policy_name
  type = var.type

  rule {
    action      = "deny(403)"
    priority    = "2147483647"
    description = "default rule"

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.deny_ip_ranges
      }
    }
  }

  rule {
    action      = "allow"
    priority    = "0"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.allow_ip_ranges
      }
    }
  }
}
