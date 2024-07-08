module "test" {
  source = "github.com/osinfra-io/terraform-google-project//global?ref=v0.2.2"

  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  description                     = "workflow"
  environment                     = var.environment
  folder_id                       = var.folder_id

  labels = {
    cost-center = "x000"
    env         = var.environment
    team        = "testing"
    repository  = "github-terraform-gcp-called-workflows"
  }

  prefix = "test"
}

module "bucket" {
  source = "github.com/osinfra-io/terraform-google-storage-bucket?ref=v0.1.3"

  force_destroy = true

  labels = {
    cost-center = "x000"
    env         = var.environment
    team        = "testing"
    repository  = "github-terraform-gcp-called-workflows"
  }

  location = "US"
  name     = "test-${random_id.test.hex}-${var.environment}"
  project  = module.test.project_id
}

resource "random_id" "test" {
  byte_length = 4
}
