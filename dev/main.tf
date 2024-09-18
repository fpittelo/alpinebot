######## Creation of Azure Web infrastructure  ########

#### Create Azure Resource Group ######

resource "azurerm_resource_group" "rg" {
  name            = var.az_rg_name
  location        = var.az_location

  tags = {
    project       = var.project
    owner         = var.owner
    department    = var.department
    status        = var.wap_status
    environment   = var.environment
  }
}

### Deploy App Insights #########

resource "azurerm_application_insights" "apbotinsights" {
  name                = var.apbotinsights_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  application_type    = "web"
}

output "instrumentation_key" {
  value = azurerm_application_insights.apbotinsights.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.apbotinsights.app_id
}

#### Deploy AlpineBot OpenAI Account ######

resource "azurerm_cognitive_account" "alpinebotaiact" {
  name                = var.alpinebotaiact
  location            = var.az_location
  resource_group_name = var.az_rg_name
  kind                = "OpenAI"
  sku_name            = "S0"
  
  tags = {
    project           = var.project
    owner             = var.owner
    department        = var.department
    status            = var.wap_status
    environment       = var.environment
  }
}

### Creation of Azure Service Plan #########
resource "azurerm_service_plan" "wap_sp_website" {
  name                = var.wap_sp_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  sku_name            = var.wap_sp_sku
  os_type             = var.wap_sp_sku_os_linux
  
  depends_on = [azurerm_resource_group.rg]  # Explicit dependency

  tags = {
    project     = var.project
    owner       = var.owner
    dept        = var.department
    status      = var.wap_status
  }
}

##### Deploy AlpineBot Azure App Service ######

resource "azurerm_linux_web_app" "wap_app" {
  name                = var.wap_website_name
  location            = var.az_location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.wap_sp_website.id
  
  depends_on = [azurerm_service_plan.wap_sp_website]  # Explicit dependency

  tags = {
    project     = var.project
    owner       = var.owner
    dept        = var.department
    status      = var.wap_status
  }

  site_config {
    linux_fx_version = "DOTNETCORE|6.0"  # Define your runtime stack (can be Python, Node, etc.)
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "AZURE_OPENAI_KEY"         = var.azure_openai_key
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.apbotinsights.instrumentation_key
  }

  
}
