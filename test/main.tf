module "test" {
  source = "github.com/osinfra-io/terraform-google-project"

  billing_account                 = var.billing_account
  cost_center                     = "x000"
  description                     = "workflow"
  cis_2_2_logging_sink_project_id = "shared-audit01-tff6-sb"
  environment                     = "sb"
  folder_id                       = "21945465219"

  labels = {
    key = "value",
  }

  prefix = "testing"
}
