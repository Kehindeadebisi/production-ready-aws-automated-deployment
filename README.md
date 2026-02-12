
# Terraform AWS Sandbox Infrastructure

This repository contains a split-root Terraform setup for deploying a sandbox AWS environment, including VPC, EC2, and S3 resources. It is designed for learning, experimentation, or as a starting point for new projects.

## Structure

```
terraform-sandbox/
├── vpc/           # Root config for VPC/networking (separate state)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── backend.tf
│
├── infra/         # Root config for EC2, S3, etc. (separate state)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── backend.tf
│
├── terraform/
│   └── modules/
│       ├── ec2/
│       └── s3/
│
├── cloudformation/
│   └── bootstrap.yml
│
├── .github/
│   └── workflows/
│       └── terraform-plan.yml
│
└── README.md
```

## State Management

- **VPC and infra have separate state files** using S3 backends, with dynamic bucket names based on your AWS account and region.
- The infra stack uses `terraform_remote_state` to read outputs from the VPC stack.

## Usage

1. **Configure AWS Credentials**
   - Use environment variables or your preferred method. No secrets are stored in this repo.

2. **Initialize Terraform in each root folder**
   ```sh
   cd vpc && terraform init
   cd ../infra && terraform init
   ```

3. **Plan and Apply**
   ```sh
   cd vpc && terraform apply
   cd ../infra && terraform apply
   ```

## Security
- **No secrets or sensitive values are stored in this repository.**
- All secrets (AWS credentials, OIDC role ARNs, etc.) must be provided via environment variables or your CI/CD secrets store.
- The .gitignore excludes tfstate, tfvars, and other sensitive/ephemeral files.

## Modules

- Modules are stored in `terraform/modules/` and can be referenced from both vpc and infra root modules.
- Example modules: `ec2`, `s3`.

## CloudFormation
- `cloudformation/bootstrap.yml` provisions OIDC provider, IAM roles, S3 backend, and DynamoDB lock table for Terraform state.

## CI/CD
- `.github/workflows/terraform-plan.yml` runs Terraform plan on PRs/branches, using dynamic backend config from CloudFormation outputs.

## Notes
- Region is set to `eu-north-1` (Stockholm).
- All resources are tagged for environment and management.
- No hardcoded secrets or credentials.

---

**For any deployment, ensure you provide your own AWS credentials and do not commit secrets to this repository.**
