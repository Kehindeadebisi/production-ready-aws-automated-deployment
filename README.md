# Terraform AWS Sandbox Infrastructure

This repository contains a modular Terraform setup for deploying a sandbox AWS environment, including VPC, EC2, and S3 resources. It is designed for learning, experimentation, or as a starting point for new projects.

## Structure

- **main.tf**: Root configuration, wiring modules and passing variables.
- **variables.tf**: All input variables for the root module.
- **outputs.tf**: Root outputs for key resources.
- **providers.tf**: Provider configuration (Stockholm region).
- **locals.tf**: Local values for project-wide tags and naming.
- **data.tf**: Data sources (e.g., latest Ubuntu AMI).
- **s3.tf**: S3 module instantiation.
- **cloudformation/bootstrap.yml**: CloudFormation template for GitHub OIDC and backend resources.
- **.github/workflows/terraform-plan.yml**: GitHub Actions workflow for Terraform plan.
- **terraform/modules/vpc/**: VPC module (uses terraform-aws-modules/vpc/aws), creates VPC, subnets, and a security group for SSH.
- **terraform/modules/ec2/**: EC2 module, launches an instance in the VPC/subnet, attaches IAM roles and EBS volume.
- **terraform/modules/s3/**: S3 module, creates a secure, versioned S3 bucket.

## Usage

1. **Configure AWS Credentials**
   - Use environment variables or your preferred method. No secrets are stored in this repo.

2. **Initialize Terraform**
   ```sh
   terraform init
   ```

3. **Plan and Apply**
   ```sh
   terraform plan -var-file="environment/sandbox.tfvars"
   terraform apply -var-file="environment/sandbox.tfvars"
   ```

## Security
- **No secrets or sensitive values are stored in this repository.**
- All secrets (AWS credentials, OIDC role ARNs, etc.) must be provided via environment variables or your CI/CD secrets store.
- The .gitignore excludes tfstate, tfvars, and other sensitive/ephemeral files.

## Modules

### VPC Module (`terraform/modules/vpc`)
- Uses the official terraform-aws-modules/vpc/aws module.
- Creates VPC, public/private subnets, NAT gateway, and a security group allowing SSH (port 22).
- Outputs: `vpc_id`, `public_subnets`, `private_subnets`, `sandbox_security_group_id`.

### EC2 Module (`terraform/modules/ec2`)
- Launches an EC2 instance in the private subnet.
- Attaches IAM role and EBS volume.
- Uses variables for AMI, instance type, subnet, and security group.

### S3 Module (`terraform/modules/s3`)
- Creates a versioned, encrypted S3 bucket with restricted public access.

## CloudFormation
- `cloudformation/bootstrap.yml` provisions OIDC provider, IAM roles, S3 backend, and DynamoDB lock table for Terraform state.

## CI/CD
- `.github/workflows/terraform-plan.yml` runs Terraform plan on PRs/branches.

## Notes
- Region is set to `eu-north-1` (Stockholm).
- All resources are tagged for environment and management.
- No hardcoded secrets or credentials.

---

**For any deployment, ensure you provide your own AWS credentials and do not commit secrets to this repository.**
