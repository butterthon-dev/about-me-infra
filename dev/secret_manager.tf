locals {
  prefix = "dev_about_me-"
}

resource "google_secret_manager_secret" "secret_django_debug" {
  project   = var.project_id
  secret_id = "${local.prefix}DJANGO_DEBUG"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "dev" }
}
resource "google_secret_manager_secret" "secret_django_settings_module" {
  project   = var.project_id
  secret_id = "${local.prefix}DJANGO_SETTINGS_MODULE"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "dev" }
}
resource "google_secret_manager_secret" "secret_django_secret_key" {
  project   = var.project_id
  secret_id = "${local.prefix}DJANGO_SECRET_KEY"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "dev" }
}
resource "google_secret_manager_secret" "secret_database_url" {
  project   = var.project_id
  secret_id = "${local.prefix}DATABASE_URL"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "dev" }
}

// secret_detaを空文字にはできない
// ※ 空文字でもapplyは成功するが、Web UI上でバージョンが登録されてない状態になる
resource "google_secret_manager_secret_version" "v_django_debug" {
  secret        = google_secret_manager_secret.secret_django_debug.id
  secret_data   = "False"
}
resource "google_secret_manager_secret_version" "v_django_settings_module" {
  secret        = google_secret_manager_secret.secret_django_settings_module.id
  secret_data   = "config.settings.dev"
}
resource "google_secret_manager_secret_version" "v_django_secret_key" {
  secret        = google_secret_manager_secret.secret_django_secret_key.id
  secret_data   = var.secret_django_secret_key
}
resource "google_secret_manager_secret_version" "v_database_url" {
  secret        = google_secret_manager_secret.secret_database_url.id
  
  # CloudRunの場合
  # secret_data = "mysql://${module.cloud_sql.sql_username}:${var.sql_user_password}@//cloudsql/${var.project}:${var.region}:${module.cloud_sql.db_instance_name}/${module.cloud_sql.db_name}?charset=utf8mb4"

  # GKEの場合
  secret_data   = "mysql://${module.cloud_sql.sql_username}:${var.sql_user_password}@127.0.0.1:3306/${module.cloud_sql.db_name}?charset=utf8mb4"
}
