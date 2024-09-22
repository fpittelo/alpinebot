# Create App Service Plan
resource "azurerm_service_plan" "wap_sp_website" {
  name                = var.wap_sp_name
  location            = var.location
  resource_group_name = var.az_rg_name
  sku_name            = var.wap_sp_sku
  os_type             = var.wap_sp_sku_os_linux

  tags = var.tags
}

# Create App Service (Web App)
resource "azurerm_linux_web_app" "wap_app" {
  name                = var.wap_website_name
  location            = var.location
  resource_group_name = var.az_rg_name
  service_plan_id     = azurerm_service_plan.wap_sp_website.id

  site_config {
    
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "AZURE_OPENAI_KEY"                = var.azure_openai_key
    "APPINSIGHTS_INSTRUMENTATIONKEY"  = var.appinsights_instrumentation_key
  }

  tags = var.tags
}
