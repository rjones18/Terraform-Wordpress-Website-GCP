resource "google_cloudbuild_trigger" "example" {
  project = "alert-flames-286515"
  name    = "WP-Infra-Trigger"
  disabled = false
  service_account = "projects/alert-flames-286515/serviceAccounts/cloudbuildaccount@alert-flames-286515.iam.gserviceaccount.com"

  trigger_template {
    repo_name   = "github_rjones18_gcp-application-infrastructure"
    branch_name = "main"
  }
  filename = "cloudbuild.yaml"
}