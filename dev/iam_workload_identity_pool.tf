resource "google_iam_workload_identity_pool" "dev_workload_identity_pool" {
  provider = google-beta
  workload_identity_pool_id = "dev-workload-identity-pool"
}

resource "google_iam_workload_identity_pool_provider" "dev_workload_identity_pool_provider" {
  provider                              = google-beta
  workload_identity_pool_id             = google_iam_workload_identity_pool.dev_workload_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id    = "dev-workload-identity-prv"
  attribute_mapping                     = {
    "google.subject"        = "assertion.sub"
    "attribute.actor"       = "assertion.actor"
    "attribute.repository"  = "assertion.repository"
    "attribute.aud"         = "assertion.aud"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "sa_github_actions" {
  service_account_id    = google_service_account.dev_sa_github_actions.id
  role                  = "roles/iam.workloadIdentityUser"
  member                = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.dev_workload_identity_pool.workload_identity_pool_id}/*"
}
