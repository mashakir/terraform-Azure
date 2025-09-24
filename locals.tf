locals {
  allowed_locations = ["uksouth", "ukeast"]
  custom_policies = {
    allowed_locations = {
      name                 = "allowed-locations"
      display_name         = "Allowed Locations"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/locations"
      parameters = {
        listOfAllowedLocations = { value = local.allowed_locations }
      }
    }
  }
}