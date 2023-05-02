resource "google_sql_database_instance" "master" {
  name = var.sqlinstancename
  database_version = "MYSQL_8_0"
  project      = var.project
  region = var.region
  deletion_protection = false
  depends_on = [var.private_vpc]

  settings {
    tier = "db-n1-standard-2"
    ip_configuration {

      ipv4_enabled                                  = false
      private_network                               = var.vpcnetworkid
      enable_private_path_for_google_cloud_services = true

    }
  }
}

resource "google_sql_user" "users" {
  name = "root"
  project      = var.project
  instance = google_sql_database_instance.master.name
  host = "%"
  password = "Chethan@12"
}

resource "google_sql_database" "database" {
  name = "mytestdatabase"
  project      = var.project
  instance = google_sql_database_instance.master.name
  charset = "utf8"
  collation = "utf8_general_ci"
}
