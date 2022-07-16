// GKEクラスタのリソース管理で使用するIAMサービスアカウント
resource "google_service_account" "dev_gke_sa_about_me" {
  account_id    = "dev-gke-sa-about-me"
  display_name  = "dev-gke-sa-about-me"
}

# 上記IAMサービスアカウントにロールをいくつか付与
# ・Cloud SQL クライアント
# ・Secret Manager のシークレット アクセサー
# ・Artifact Registry 管理者
# ・ストレージオブジェクト閲覧者
resource "google_project_iam_member" "dev_sa_sql_client_about_me" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.dev_gke_sa_about_me.email}"
}
resource "google_project_iam_member" "dev_sa_secret_accessor_about_me" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.dev_gke_sa_about_me.email}"
}
resource "google_project_iam_member" "dev_sa_artifact_registry_reader_about_me" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.dev_gke_sa_about_me.email}"
}
resource "google_project_iam_member" "dev_sa_storage_viewer_about_me" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.dev_gke_sa_about_me.email}"
}

/**
 * クラスターの作成に10分くらい時間が掛かる
 * ノードプールの作成に3分くらい時間が掛かる
 */
resource "google_container_cluster" "cluster_about_me" {
  name      = "cluster-about-me"
  location  = var.region
  provider  = google-beta

  # enable_autopilot          = true
  remove_default_node_pool  = true
  initial_node_count        = 1

  node_config {
    service_account = google_service_account.dev_gke_sa_about_me.email // GKEサービスアカウント
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # pod_security_policy_config {
  #   enabled = true
  # }

  # GKEサービスアカウントをIAMのサービスアカウントとして機能させる
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_container_node_pool" "node_pool_about_me" {
  name          = "node-pool-dev-app"
  location      = var.region
  cluster       = google_container_cluster.cluster_about_me.name
  node_count    = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 10
  }

  node_config {
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}
