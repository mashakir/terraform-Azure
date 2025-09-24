output "policy_id" {
  value = azurerm_policy_set_definition.policy_set.id
}

output "policy_assignment_id" {
  value = coalesce(
    try(azurerm_management_group_policy_assignment.management_group, null),
    try(azurerm_subscription_policy_assignment.subscription, null)
  )
}