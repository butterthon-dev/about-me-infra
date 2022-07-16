variable "db_name" { type = string }
variable "db_instance_name" { type = string }
variable "region" { type = string }
variable "database_version" {
    type    = string
    default = "MYSQL_8_0"
}
variable "tier" {
    type = string
    default = "db-f1-micro"
}
variable "deletion_protection" {
  type = bool
  default = false
}
variable "username" { type = string }
variable "sql_user_password" { type = string }
# variable "private_network_id" { type = string }
# variable "private_vpc_conn" { type = any }
