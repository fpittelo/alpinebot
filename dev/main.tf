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

# Create the Azure Key Vault
resource "azurerm_key_vault" "alpinebot_kv" {
  name                        = var.az_kv_name
  location                    = var.az_location
  resource_group_name          = azurerm_resource_group.rg.name
  tenant_id                   = var.az_tenant_id
  sku_name                    = "standard"

  tags = {
    environment = var.environment
    project     = var.project
    owner       = var.owner
  }
}

# Key Vault Access Policy - Grants access to App Service Identity
resource "azurerm_key_vault_access_policy" "apbot_policy" {
  key_vault_id = azurerm_key_vault.alpinebot_kv.id
  tenant_id    = var.az_tenant_id
  object_id    = var.service_principal_object_id  # Use the variable


  secret_permissions = [
    "Get",
    "List"
  ]
}

# Store OpenAI API Key in Key Vault
resource "azurerm_key_vault_secret" "openai_api_key" {
  name         = var.az_kv_name
  value        = var.azure_openai_key   # Retrieved securely in the workflow
  key_vault_id = azurerm_key_vault.alpinebot_kv.id
  
  tags = {
    project     = var.project
    owner       = var.owner
    department  = var.department
    status      = var.wap_status
    environment = var.environment
  }
}

# Output Key Vault name and URL for later use
output "key_vault_name" {
  value = azurerm_key_vault.alpinebot_kv.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.alpinebot_kv.vault_uri
}

### Deploy App Insights #########

resource "azurerm_application_insights" "apbotinsights" {
  name                = var.apbotinsights_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  application_type    = "web"

  depends_on = [azurerm_resource_group.rg]  # Ensures this resource is created after the resource group
}

output "instrumentation_key" {
  value = azurerm_application_insights.apbotinsights.instrumentation_key
  sensitive = true  # Mark as sensitive
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
  
  depends_on = [azurerm_resource_group.rg]  # Ensures this resource is created after the resource group

  tags = {
    project           = var.project
    owner             = var.owner
    department        = var.department
    status            = var.wap_status
    environment       = var.environment
  }
  
}

# Output the OpenAI key (on the fly) after deployment

output "azure_openai_key" {
  value = azurerm_cognitive_account.alpinebotaiact.primary_access_key
  sensitive = true
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
  service_plan_id     = azurerm_service_plan.wap_sp_website.id
  
  depends_on = [azurerm_cognitive_account.alpinebotaiact, azurerm_service_plan.wap_sp_website]

  tags = {
    project     = var.project
    owner       = var.owner
    dept        = var.department
    status      = var.wap_status
  }

  site_config {
     # No need for linux_fx_version here in recent versions
  }

  app_settings = {
  "WEBSITE_RUN_FROM_PACKAGE"        = "1"
  
  # Use Key Vault Reference for the OpenAI Key
  "AZURE_OPENAI_KEY" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault.alpinebot_kv.vault_uri}secrets/openai-api-key)"
  
  "APPINSIGHTS_INSTRUMENTATIONKEY"  = azurerm_application_insights.apbotinsights.instrumentation_key
  }
}
