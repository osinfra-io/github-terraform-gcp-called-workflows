terraform {
  backend "gcs" {
    prefix = "github-terraform-called-workflows"
  }
}
