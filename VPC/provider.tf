terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "alert-flames-286515"
  region  = "us-central1"
  zone    = "us-central1-a"
  #credentials = "keys-tf.json"
}