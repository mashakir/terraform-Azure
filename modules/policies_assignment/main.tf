
 # Create a policy set definition that includes the default security policies
resource "azurerm_policy_set_definition" "policy_set" {
  name         = local.policy_name
  display_name = local.policy_display_name
  description  = local.policy_description
  policy_type  = "Custom"

  metadata = jsonencode({
    category = "Baseline Policies"
  })

  dynamic "policy_definition_reference" {
    for_each = local.merged_policies

    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      reference_id         = policy_definition_reference.key
      parameter_values     = jsonencode(
        lookup(policy_definition_reference.value, "parameters", {})
      )
    }
  }
}

# Assign the baseline policy set definition at the subscription level as needed
resource "azurerm_management_group_policy_assignment" "management_group" {
  count                = var.scope_type == "management_group" ? 1 : 0
  name                 = "${local.policy_name}-${local.asssignment_code}"
  display_name         = "${local.policy_display_name} Assignment"
  policy_definition_id = azurerm_policy_set_definition.policy_set.id
  management_group_id  = var.scope_id
}

resource "azurerm_subscription_policy_assignment" "subscription" {
  count                = var.scope_type == "subscription" ? 1 : 0
   name                 = "${local.policy_name}-${local.asssignment_code}"
  display_name         = "${local.policy_display_name} Assignment"
  policy_definition_id = azurerm_policy_set_definition.policy_set.id
  subscription_id      = var.scope_id
}
 