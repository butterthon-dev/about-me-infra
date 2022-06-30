resource "google_storage_bucket" "bucket_about_me" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true // バケットの中にオブジェクトが残っていても強制的に削除

  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_default_object_access_control" "public_acl_about_me" {
  bucket  = google_storage_bucket.bucket_about_me.name
  role    = "READER"
  entity  = "allUsers"
}
