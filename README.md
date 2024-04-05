# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/201473670-e0e6bdeb-742f-4be1-a47a-3506309620a3.png"> Terraform Google Cloud Platform Called Workflows

**[GitHub Actions](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions):**

[![Dependabot](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions/workflows/local-dependabot.yml/badge.svg)](https://github.com/osinfra-io/github-terraform-gcp-called-workflows/actions/workflows/local-dependabot.yml)

Reusing workflows avoids duplication. This makes workflows easier to maintain and allows you to create new workflows
more quickly by building on the work of others, just as you do with actions.

Workflow reuse also promotes best practices by helping you use well-designed, tested, and proven effective workflows. Your organization can build up a library of reusable workflows that can
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
- [test.yml](.github/workflows/test.yml)

### Plan and Apply Usage

You can check the [.github/workflows](.github/workflows/) directory for example configurations ([sandbox.yml](.github/workflows/sandbox.yml), [non-production.yml](.github/workflows/non-production.yml), [production.yml](.github/workflows/production.yml)). These set up the system for the testing process by providing all the necessary initial code, thus creating good examples to base your configuration on.

Here is an example of a basic configuration:

```yaml
name: Sandbox

on:
  workflow_dispatch:
  pull_request:
    types:
      - opened
      - synchronize
    paths-ignore:
      - "**.md"

# For reusable workflows, the permissions setting for id-token should be set to write at the
# caller workflow level or the specific job that calls the reusable workflow.

permissions:
  id-token: write

jobs:
  global_infra:
    name: Global
    uses: osinfra-io/github-terraform-gcp-called-workflows/.github/workflows/plan-and-apply.yml@v0.0.0
    if: github.actor != 'dependabot[bot]'
    with:
      checkout_ref: ${{ github.ref }}
      environment: sandbox
      github_environment: "Sandbox Infrastructure: Global"
      service_account: example@example-project-sb.iam.gserviceaccount.com
      terraform_plan_args: -var-file=tfvars/sandbox.tfvars
      terraform_state_bucket: example-state-bucket-sb
      terraform_version: ${{ vars.TERRAFORM_VERSION }}
      terraform_workspace: global-sandbox
      working_directory: test
      workload_identity_provider: projects/123456789876/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc
    secrets:
      gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
      infracost_api_key: ${{ secrets.INFRACOST_API_KEY }}
      terraform_plan_secret_args: -var="billing_account=${{ secrets.BILLING_ACCOUNT }}"
```

### Test Usage

Here is an example of a basic configuration:

```yaml
name: Terraform Tests

on:
  workflow_dispatch:
  pull_request:
    types:
      - opened
      - synchronize
    paths-ignore:
      - "**.md"

# For reusable workflows, the permissions setting for id-token should be set to write at the
# caller workflow level or the specific job that calls the reusable workflow.

permissions:
  id-token: write

jobs:
  tests:
    name: "Default"
    uses: osinfra-io/github-terraform-gcp-called-workflows/.github/workflows/test.yml@v0.0.0
    if: github.actor != 'dependabot[bot]'

    with:
      service_account: example@example-project-sb.iam.gserviceaccount.com
      terraform_version: ${{ vars.TERRAFORM_VERSION }}
      workload_identity_provider: projects/123456789876/locations/global/workloadIdentityPools/github-actions/providers/github-actions-oidc
```
