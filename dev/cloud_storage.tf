module "cloud_storage" {
  source = "../modules/cloud_storage"

  region        = var.region
  bucket_name   = "dev-about-me"
}
