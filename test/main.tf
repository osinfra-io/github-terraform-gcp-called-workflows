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
    test        = "bar"
  }

  prefix = "testing"
}
