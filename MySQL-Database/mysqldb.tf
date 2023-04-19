data "google_secret_manager_secret_version" "my_user_secret" {
  provider = google-beta
  secret   = "wordpress-username"
  version  = "2"
  project  = "alert-flames-286515"
}

data "google_secret_manager_secret_version" "my_db_secret" {
  provider = google-beta
  secret   = "wordpress-db-password"
  version  = "1"
  project  = "alert-flames-286515"
}

resource "google_sql_database" "example-database" {
  name     = "wordpress"
  instance = google_sql_database_instance.example-instance.name
}

resource "google_sql_database_instance" "example-instance" {
  name                = "wordpress-sql-instance"
  database_version    = "MYSQL_5_7"
  region              = "us-central1"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/alert-flames-286515/global/networks/project-vpc"
    }
  }
}


resource "google_sql_user" "user" {
  name     = data.google_secret_manager_secret_version.my_user_secret.secret_data
  instance = google_sql_database_instance.example-instance.name
  password = data.google_secret_manager_secret_version.my_db_secret.secret_data
  host     = "%"
}

