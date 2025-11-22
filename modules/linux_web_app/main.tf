# Create App Service (Web App)
resource "azurerm_linux_web_app" "wap_app" {
  name                = var.wap_website_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  service_plan_id     = var.service_plan_id
  
  site_config {
    always_on = true
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.app_settings

  auth_settings_v2 {
    auth_enabled           = var.auth_enabled
    require_authentication = false
    unauthenticated_action = "AllowAnonymous"
    
    login {
      token_store_enabled = true
    }

    google_v2 {
      client_id                = var.google_client_id
      client_secret_setting_name = var.google_client_secret_setting_name
      login_scopes             = ["openid", "profile", "email"]
    }

  }

  tags = var.tags
}