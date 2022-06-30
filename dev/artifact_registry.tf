module "artifact_registry" {
  source = "../modules/artifact_registry"

  region        = var.region
  repository_id = "dev-about-me-repository"
}
