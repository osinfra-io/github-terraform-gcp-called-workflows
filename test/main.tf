module "storage_bucket" {
  source = "git@github.com:idexx-labs/terraform-google-storage-bucket.git?ref=v1.0.0"

  labels = {
    "environment" = "sandbox"
    "test"        = "x"
  }

  location   = "us-east1"
  name       = "test-plan-and-apply"
  project_id = "devops-testing-tf40dbd6-sb"
}
