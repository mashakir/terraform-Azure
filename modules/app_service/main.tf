resource "azurerm_windows_web_app" "app_as" {
  name                = format("%s-%s", var.rg_name, "as")
  location            = var.rg_location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true   # Enforce HTTPS only

  identity {
    type = "SystemAssigned"  # Enable Managed Identity
  }

  site_config {
    always_on     = true    # Recommended for production
    http2_enabled = true    # Enable HTTP/2

    cors {
      allowed_origins = []  # Disallow all CORS by default
    }

    application_stack {
      current_stack = "dotnet"
      dotnet_version = "v6.0"   # Updated to supported version
    }

    remote_debugging_enabled = false   # Disable remote debugging
    ftps_state               = "Disabled"  # Disable FTP/FTPS deployments
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "APPINSIGHTS_INSTRUMENTATIONKEY"      = data.azurerm_application_insights.app_ai.instrumentation_key
  }

  auth_settings {
    enabled = true   # Enforce App Service Authentication
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }

  tags = merge({}, var.common_tags)
}
