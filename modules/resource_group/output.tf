output "rg_location" {
  value       = var.location
  description = "Name variable for Resource Group"
}
output "rg_name" {
  value       = var.name
  description = "Location variable for Resource Group"
}
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}