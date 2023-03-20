terraform {
  backend "gcs" {
    prefix = "devops-gcp-called-workflows"
  }
}
