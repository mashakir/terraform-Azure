# Environment Variables
module "env_vars" {
  source = "./modules/env_vars"
  std_tags = {
    Environment = var.environment
    Region      = var.location
  }
}

# Get current subscription details
data "azurerm_subscription" "current" {}

# Assiging policies
module "policies_assignments" {
  source           = "./modules/policies_assignment"
  scope_id         = var.policy_scope_id
  scope_type       = var.scope_type
  common_tags      = module.env_vars.common_tags
  enforce_all_tags = true
  policies         = local.custom_policies
}

# Create a resource group
module "resource_group" {
  source      = "./modules/resource_group"
  name        = var.resource_group_name
  location    = var.location
  common_tags = module.env_vars.common_tags
}

# Create Application Insights
module "app_insights" {
  source      = "./modules/app_insights"
  rg_name     = var.resource_group_name
  rg_location = var.location
  common_tags = module.env_vars.common_tags
  depends_on  = [module.resource_group]
}
# Create an App Service
module "app_service" {
  source      = "./modules/app_service"
  rg_name     = var.resource_group_name
  rg_location = var.location
  common_tags = module.env_vars.common_tags
  os_type     = "Windows"
  sku_name    = "F1"

  depends_on = [module.resource_group, module.app_insights]
}
# Create an API Management instance
module "api_management" {
  source      = "./modules/api_management"
  rg_name     = var.resource_group_name
  rg_location = var.location
  sku_name    = "Consumption_0"
  common_tags = module.env_vars.common_tags
  depends_on  = [module.resource_group]
}