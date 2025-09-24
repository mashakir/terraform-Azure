# Environment Variables Module

This Terraform module standardizes and manages environment variables and tags for Azure resources, ensuring consistent resource metadata across your Azure environment.

## Features

- Enforces a set of recommended standard tags for all Azure resources.
- Simplifies tag management and promotes governance best practices.
- Outputs a merged map of tags for easy reuse in resource definitions.

## Inputs

| Name         | Type         | Description                                                                 | Required |
|--------------|--------------|-----------------------------------------------------------------------------|----------|
| std_tags     | map(string)  | Map of standard tags to apply to all resources. Recommended keys:<br>- `Environment`<br>- `Team`<br>- `Owner`<br>- `Project`<br>- `CostCenter`<br>- `Department`<br>- `BusinessCriticality`<br>- `Compliance`<br>- `ManagedBy` (default: `Terraform`) | Yes      |

## Output

| Name        | Description                                      |
|-------------|--------------------------------------------------|
| common_tags | Merged map of standard tags for Azure resources. |

## Usage

```hcl
module "env_vars" {
  source   = "./modules/env_vars"
  std_tags = {
    Environment         = var.environment
  }
}
```

You can then use `module.env_vars.common_tags` as the `tags` argument in your Azure resource definitions:

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = var.location
  tags     = module.env_vars.common_tags
}
```

## Recommendations

- Always include the recommended tags to support cost management, compliance, and operational visibility.
- Use this module as a baseline for all Azure resource modules to ensure consistent tagging.

---