module "cloud_sql" {
  source = "../modules/cloud_sql"

  db_name             = "dev-db-about-me"
  db_instance_name    = "dev-db-instance-about-me"
  region              = var.region
  username            = "admin"
  sql_user_password   = var.sql_user_password
  private_network_id  = google_compute_network.dev_private_network_about_me.id
  private_vpc_conn    = google_service_networking_connection.dev_private_vpc_conn_about_me
}
