# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/201473670-e0e6bdeb-742f-4be1-a47a-3506309620a3.png"> Terraform Google Cloud Platform Called Workflows

**[GitHub Actions](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions):**

[![Dependabot](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions/workflows/local-dependabot.yml/badge.svg)](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions/workflows/local-dependabot.yml) [![Tests](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions/workflows/test-plan-and-apply.yml/badge.svg)](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions/workflows/test-plan-and-apply.yml)

Reusing workflows avoids duplication. This makes workflows easier to maintain and allows you to create new workflows
more quickly by building on the work of others, just as you do with actions.

Workflow reuse also promotes best practice by helping you to use workflows that are well designed, have already been
tested, and have been proved to be effective. Your organization can build up a library of reusable workflows that can
be centrally maintained.

## Reusing Workflows

Rather than copying and pasting from one workflow to another, you can make workflows [reusable](https://docs.github.com/en/actions/learn-github-actions/reusing-workflows). You and anyone with access to the reusable workflow can then call the reusable workflow from another workflow.

### Features

- [Approve or reject jobs awaiting review](https://docs.github.com/en/actions/managing-workflow-runs/reviewing-deployments)
- [Dependencies cache](https://docs.github.com/en/actions/advanced-guides/caching-dependencies-to-speed-up-workflows)
- [Job summaries](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#adding-a-job-summary)
- [OpenID connect in Google Cloud Platform](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-google-cloud-platform)

### Workflows

- [plan-and-apply.yml](.github/workflows/plan-and-apply.yml)

### Example Google Cloud Platform Usage

```yaml
name: Development

on:
  push:
    branches:
      - main

# For reusable workflows, the permissions setting for id-token should be set to write at the
# caller workflow level or in the specific job that calls the reusable workflow.

permissions:
  id-token: write

jobs:
  global_infra:
    name: "Global"
    uses: osinfra-io/github-terraform-called-workflows/.github/workflows/gcp-plan-and-apply.yml@v0.0.0
    if: github.actor != 'dependabot[bot]'
    with:
      checkout_ref: ${{ github.ref }}
      github_environment: "Sandbox Infrastructure: Global"
      service_account: "service-account@project-id.iam.gserviceaccount.com"
      terraform_state_bucket: "terraform-state-bucket-sb"
      terraform_version: ${{ vars.TERRAFORM_VERSION }}
      terraform_workspace: global-sandbox
      working_directory: global
      workload_identity_provider: "projects/123456789876/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc"
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      terraform_plan_secret_args: -var="billing_account=${{ secrets.BILLING_ACCOUNT }}"

  us_east1_infra:
    name: "Infra: us-east1"
    uses: osinfra-io/github-terraform-called-workflows/.github/workflows/gcp-plan-and-apply.yml@v0.0.0
    needs: global_infra
    with:
      checkout_ref: ${{ github.ref }}
      github_environment: "Sandbox Infrastructure: us-east1"
      service_account: "service-account@project-id.iam.gserviceaccount.com"
      terraform_state_bucket: "terraform-state-bucket-sb"
      terraform_version: ${{ vars.TERRAFORM_VERSION }}
      terraform_workspace: us-east1-sandbox
      working_directory: regional
      workload_identity_provider: "projects/123456789876/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc"
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      terraform_plan_secret_args: -var="billing_account=${{ secrets.BILLING_ACCOUNT }}"

   us_east4_infra:
    name: "Infra: us-east4"
    uses: osinfra-io/github-terraform-called-workflows/.github/workflows/gcp-plan-and-apply.yml@v0.0.0
    needs: global_infra
    with:
      checkout_ref: ${{ github.ref }}
      github_environment: "Sandbox Infrastructure: us-east4"
      service_account: "service-account@project-id.iam.gserviceaccount.com"
      terraform_state_bucket: "terraform-state-bucket-sb"
      terraform_version: ${{ vars.TERRAFORM_VERSION }}
      terraform_workspace: us-east4-sandbox
      working_directory: regional
      workload_identity_provider: "projects/123456789876/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc"
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      terraform_plan_secret_args: -var="billing_account=${{ secrets.BILLING_ACCOUNT }}"
```
