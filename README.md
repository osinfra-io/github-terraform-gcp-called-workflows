# Reusable Called Workflows for Terraform

Reusing workflows avoids duplication. This makes workflows easier to maintain and allows you to create new workflows
more quickly by building on the work of others, just as you do with actions.

Workflow reuse also promotes best practice by helping you to use workflows that are well designed, have already been
tested, and have been proved to be effective. Your organization can build up a library of reusable workflows that can
be centrally maintained.

## Reusing Workflows

Rather than copying and pasting from one workflow to another, you can make workflows [reusable](https://docs.github.com/en/actions/learn-github-actions/reusing-workflows). You and anyone with access to the reusable workflow can then call the reusable workflow from another workflow.

### Example Usage

```yaml
name: Development

on:
  push:
    branches:
      - main

jobs:
  global_infra:
    name: "Global"
    uses: osinfra-io/github-terraform-called-workflows/.github/workflows/gcp-plan-and-apply-called.yml@v0.0.0
    with:
      checkout_ref: ${{ github.ref }}
      github_env: "Development Infrastructure: Global"
      service_account: my-non-prod-serviceaccount@iam.gserviceaccount.com
      terraform_version: 1.3.4
      tf_plan_args: -var-file=tfvars/dev.tfvars
      tf_state_bucket: my-non-prod-state-bucket
      tf_workspace: my-non-prod-workspace
      working_dir: global
      workload_identity_provider: projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      ssh_key: ${{ secrets.RO_SSH_PRIV_KEY }}
      tf_plan_secret_args: -var="bridgecrew_token=${{ secrets.BRIDGECREW_TOKEN }}"

  us_east1_infra:
    name: "Infra: us-east1"
    uses: osinfra-io/github-terraform-called-workflows/.github/workflows/gcp-plan-and-apply-called.yml@v0.0.0
    needs: global_infra
    with:
      checkout_ref: ${{ github.ref }}
      github_env: "Development Infrastructure: Regional - us-east1"
      service_account: my-non-prod-serviceaccount@iam.gserviceaccount.com
      terraform_version: 1.3.4
      tf_plan_args: -var-file=tfvars/us-east1-dev.tfvars
      tf_state_bucket: my-non-prod-state-bucket
      tf_workspace: my-non-prod-workspace-us-east1
      working_dir: regional
      workload_identity_provider: projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      ssh_key: ${{ secrets.RO_SSH_PRIV_KEY }}

   us_east4_infra:
    name: "Infra: us-east4"
    uses: osinfra-io/github-terraform-called-workflows/.github/workflows/gcp-plan-and-apply-called.yml@v0.0.0
    needs: global_infra
    with:
      checkout_ref: ${{ github.ref }}
      github_env: "Development Infrastructure: Regional - us-east4"
      service_account: my-non-prod-serviceaccount@iam.gserviceaccount.com
      terraform_version: 1.3.4
      tf_plan_args: -var-file=tfvars/us-east4-dev.tfvars
      tf_state_bucket: my-non-prod-state-bucket
      tf_workspace: my-non-prod-workspace-us-east4
      working_dir: regional
      workload_identity_provider: projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      ssh_key: ${{ secrets.RO_SSH_PRIV_KEY }}
```
