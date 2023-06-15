module "test" {
  source = "github.com/osinfra-io/terraform-google-project//global?ref=v0.1.2"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  cost_center                     = "x000"
  description                     = "workflow"
  environment                     = var.environment
  folder_id                       = var.folder_id

  labels = {
    environment = var.environment
    test        = "foo"
  }

  prefix = "testing"
}

module "bucket" {
  source = "github.com/osinfra-io/terraform-google-storage-bucket?ref=v0.1.0"

  force_destroy = true
  location      = "US"
  name          = "test-tf5t72-${var.environment}"
  project       = module.test.project_id
}
