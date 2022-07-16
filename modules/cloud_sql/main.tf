// Cloud SQL Admin APIを有効にしておく（5分くらい待った方がいい）
// そもそもSQLインスタンスの生成に時間が掛かるので、applyも時間かかる（15分前後）
resource "google_sql_database" "db_about_me" {
  name      = var.db_name
  instance  = google_sql_database_instance.instance_about_me.id
}

resource "google_sql_database_instance" "instance_about_me" {
  name                = var.db_instance_name
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection

  settings {
    # CloudSQLインスタンスタイプ
    tier = var.tier

    // パブリックIP無効
    # ip_configuration {
    #   ipv4_enabled = false
    #   private_network = var.private_network_id
    # }
  }
}

resource "google_sql_user" "sql_user" {
  name      = var.username
  instance  = google_sql_database_instance.instance_about_me.name
  password  = var.sql_user_password
}
