module "test" {
  source = "github.com/osinfra-io/terraform-google-project"

  billing_account                 = var.billing_account
  cost_center                     = "x000"
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
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
  source = "github.com/osinfra-io/terraform-google-storage-bucket"

  force_destroy = true
  location      = "US"
  name          = "test"
  project       = module.test.project_id
}
