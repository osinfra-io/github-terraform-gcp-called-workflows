# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-google-project

module "project" {
  source = "github.com/osinfra-io/opentofu-google-project?ref=f00d14e22e192f63d910cabd73b04340281a9713"

  cis_2_2_logging_sink_project_id = var.project_cis_2_2_logging_sink_project_id
  description                     = "workflow"
  folder_id                       = var.project_folder_id
  labels                          = module.helpers.labels
  prefix                          = "test"
}

# Google Storage Bucket Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-google-storage-bucket

module "bucket" {
  source = "github.com/osinfra-io/opentofu-google-storage-bucket?ref=642c3eb45623e0e619dcc3c80c98ef804da7c153"

  force_destroy = true
  labels        = module.helpers.labels
  location      = "US"
  name          = "test-${random_id.test.hex}-${module.helpers.env}"
  project       = module.project.id
}

resource "random_id" "test" {
  byte_length = 4
}
