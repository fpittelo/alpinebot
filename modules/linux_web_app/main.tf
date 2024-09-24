# Create App Service (Web App)
resource "azurerm_linux_web_app" "wap_app" {
  name                = var.wap_website_name
  location            = var.location
  resource_group_name = var.az_rg_name
  service_plan_id     = var.wap_sp_name
  
  site_config {
    always_on = true
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.app_settings

  tags = var.tags
}
