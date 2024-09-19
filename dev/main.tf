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
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.az_tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true  # Enable Azure RBAC authorization
  tags = {
    environment = var.environment
    project     = var.project
    owner       = var.owner
  }
}

# Assign Key Vault Secrets User role to the Service Principal
resource "azurerm_role_assignment" "pipeline_sp_kv_access" {
  scope                = azurerm_key_vault.alpinebot_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.sp_object_id  # We'll obtain this in the next step
}

# Grant the App Service's Managed Identity Access to the Key Vault
resource "azurerm_role_assignment" "app_service_kv_access" {
  scope                = azurerm_key_vault.alpinebot_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_web_app.wap_app.identity.principal_id

  depends_on = [
    azurerm_linux_web_app.wap_app
  ]
}

# Store OpenAI API Key in Key Vault
resource "azurerm_key_vault_secret" "openai_key_name" {
  name         = var.az_openai_key_name
  value        = var.az_openai_key_value
   # Retrieved securely in the workflow
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

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "AZURE_OPENAI_KEY" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.openai_key_name.id})"
    "APPINSIGHTS_INSTRUMENTATIONKEY"  = azurerm_application_insights.apbotinsights.instrumentation_key
  
  }
}
