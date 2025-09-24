# Terraform
[![Terraform-Development](https://github.com/NimbleDevOps/Terraform-cloud/actions/workflows/main.yml/badge.svg)](https://github.com/NimbleDevOps/Terraform-cloud/actions/workflows/main.yml)

## Overview

This repository contains Terraform code for provisioning and managing Azure resources using a modular approach. The root module references all child modules and includes provider configuration.

## Structure

- **modules/env_vars**: Manages standard tags and environment variables for Azure resources.
- **modules/resource_group**: Creates and manages Azure resource groups.
- **modules/policies_assignment**: Assigns Azure Policy definitions at the desired scope.
- **modules/app_insights**: Provisions Application Insights resources.
- **modules/app_service**: Provisions Azure App Service resources.
- **modules/api_management**: Provisions Azure API Management instances.

## Usage

Update your `terraform.tfvars` or environment variables with required values, then run:

```sh
terraform init
terraform fmt
terraform validate
terrascan scan   
terraform plan
terraform apply
```

```hcl
module "env_vars" {
  source = "./modules/env_vars"
  std_tags = {
    Environment = var.environment
    Region      = var.location
  }
}

module "resource_group" {
  source      = "./modules/resource_group"
  name        = var.resource_group_name
  location    = var.location
  common_tags = module.env_vars.common_tags
}
```

## Best Practices

- Use modules to promote reusability and consistency.
- Store sensitive values securely (e.g., use Azure Key Vault).
- Use `common_tags` for consistent resource tagging.
- Review and follow Azure and Terraform security best practices.