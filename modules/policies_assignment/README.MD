# Policies Assignment Module

This module manages the assignment of Azure Policy definitions and initiatives (policy sets) at a specified scope, such as a subscription or management group.

## Inputs
- `scope_id` (string, **required**)):  
  The management group or subscription ID for policies assignment.

- `policies` (map(object), **optional**)):  
  Map of policy definitions to assign. 

- `scope_type` (string, **required**)):  
  The type of the policy scope (`management_group`, `subscription`).

- `common_tags` (map(string), **required**))):  
  A map of tags to apply to the policy assignment resources.

- `enforce_all_tags` (bool, *optional*)):  
  Whether to enforce all tags. Default is `false`.

- `enforce_tags_list` (list(string), *optional*):  
  List of specific tags to enforce if not enforcing all.

## Outputs

- `policy_id`:  
  Id of the baseline policy

- `policy_assignment_id`:
  Id of the policy assighnment.

---

## Usage Examples

### 1. Baseline Assignment with Management Group and Enforcing All Tags

```hcl
module "policies_assignment" {
  source              = "./modules/policies_assignment"
  scope_id   = "contoso-mg"
  scope_type = "management_group" 
  common_tags         = {
    Environment = var.environment
    Team        = var.team
    Owner       = var.owner
    Project     = var.project
    CostCenter  = var.cost_center
    Department  = var.department
    ManagedBy   = "Terraform"
  }
  enforce_all_tags = true
}
```

### 2. Baseline Custom policies Assignment with Subscription and Enforcing Specific Tags

```hcl
module "policies_assignment" {
  source              = "./modules/policies_assignment"
  scope_id   = data.azurerm_subscription.current.id
  scope_type = "subscription"
  policies = var.policies
  common_tags         = {
    Environment = var.environment
    Owner       = var.owner
    CostCenter  = var.cost_center
    ManagedBy   = "Terraform"
  }
  enforce_tags_list = ["Environment", "ManagedBy", "CostCenter"]
}
```

### 3. Baseline Assignment with Management Group Without Tags

```hcl
module "policies_assignment" {
  source              = "./modules/policies_assignment"
  scope_id   = "contoso-mg"
  scope_type = "management_group" 
}
```