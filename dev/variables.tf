variable "credentials_file_path" {
  type        = string
  description = "サービスアカウントJSONファイルのパス"
}

variable "project_id" {
  type        = string
  description = "プロジェクトID"
}

variable "project_number" {
  type        = string
  description = "プロジェクトNo."
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "zone" {
  type    = string
  default = "asia-northeast1-a"
}

variable "deny_ip_ranges" {
  type      = list(string)
  sensitive = true
}

variable "allow_ip_ranges" {
  type      = list(string)
  sensitive = true
}

variable "sql_user_password" {
  type      = string
  sensitive = true
}

variable "secret_django_secret_key" {
  type      = string
  sensitive = true
}
