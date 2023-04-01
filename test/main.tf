module "test" {
  source = "github.com/osinfra-io/terraform-google-project"

  billing_account                 = var.billing_account
  cost_center                     = "x000"
  description                     = "workflow"
  cis_2_2_logging_sink_project_id = "plt-lz-audit01-tf6e-sb"
  environment                     = var.environment
  folder_id                       = "1069400145815"

  labels = {
    environment = var.environment
    test        = "bar"
  }

  prefix = "testing"
}
