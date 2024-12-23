# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "project" {
  source = "github.com/osinfra-io/terraform-google-project?ref=v0.4.5"

  cis_2_2_logging_sink_project_id = var.project_cis_2_2_logging_sink_project_id
  description                     = "workflow"
  folder_id                       = var.project_folder_id
  labels                          = module.helpers.labels
  prefix                          = "test"
}

# Google Storage Bucket Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-storage-bucket

module "bucket" {
  source = "github.com/osinfra-io/terraform-google-storage-bucket?ref=v0.2.0"

  force_destroy = true
  labels        = module.helpers.labels
  location      = "US"
  name          = "test-${random_id.test.hex}-${module.helpers.env}"
  project       = module.project.id
}

resource "random_id" "test" {
  byte_length = 4
}
