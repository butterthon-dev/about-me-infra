output "db_name" {
  value = google_sql_database.db_about_me.name
}
output "db_instance_name" {
  value = google_sql_database_instance.instance_about_me.name
}
output "sql_username" {
  value = google_sql_user.sql_user.name
}
