terraform {
  backend "gcs" {
    bucket = "97338965b376bfd2-bucket-tfstate"
    prefix = "terraform/state/wordpress-appliction-infrastructure"
  }
}