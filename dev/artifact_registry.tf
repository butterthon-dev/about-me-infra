locals {
  repository_ids = toset([
    "dev-about-me-api-repository"
  ])
}

module "artifact_registry" {
  source = "../modules/artifact_registry"

  for_each      = local.repository_ids
  region        = var.region
  repository_id = each.key
}
