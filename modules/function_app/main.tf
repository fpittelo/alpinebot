# Storage Account for Function App
resource "azurerm_storage_account" "function_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.az_rg_name
  location                 = var.az_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# Linux Function App
resource "azurerm_linux_function_app" "function_app" {
  name                       = var.function_app_name
  location                   = var.az_location
  resource_group_name        = var.az_rg_name
  service_plan_id            = var.service_plan_id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  virtual_network_subnet_id  = var.virtual_network_subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }
    
    always_on = true

    cors {
      allowed_origins = var.cors_allowed_origins
    }
  }

  app_settings = merge(
    {
      "FUNCTIONS_WORKER_RUNTIME"              = "python"
      "AzureWebJobsFeatureFlags"              = "EnableWorkerIndexing"
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.app_insights_connection_string
      "SCM_DO_BUILD_DURING_DEPLOYMENT"        = "true"
      "ENABLE_ORYX_BUILD"                     = "true"
    },
    var.app_settings
  )

  tags = var.tags
}
