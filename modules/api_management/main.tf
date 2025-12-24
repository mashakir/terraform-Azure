resource "azurerm_api_management" "apim" {
  name                = local.apim_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  publisher_name      = "Personal"
  publisher_email     = "personal@terraform.io"
  sku_name            = var.sku_name

  # Enable Virtual Network Integration (External or Internal)
  virtual_network_type = "External"  # Internal for private fully isolated network

  # Disable public access if required
  public_network_access_enabled = false

  tags = merge(
    {},
    var.common_tags
  )

  policy {
    xml_content = <<XML
<policies>
    <inbound />
    <backend />
    <outbound />
    <on-error />
</policies>
    XML
  }
}
resource "azurerm_api_management_api" "sample_api" {
  name                = "sample-api"
  resource_group_name = var.rg_name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Sample API"
  path                = "sample"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/examples/v3.0/petstore.json"
  }
}