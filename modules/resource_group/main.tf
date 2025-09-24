# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags = merge({
    },
    var.common_tags
  )
}

resource "azurerm_management_lock" "rg-level" {
  name       = "${var.name}-lock"
  scope      = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"
  notes      = "Locking the resource group to prevent accidental deletion of resources and it is managed by Terraform."
  
}