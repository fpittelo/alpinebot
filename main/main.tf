#### Creation of Azure infra ##########

#### Create Azure Resource Group ######

resource "azurerm_resource_group" "rg" {
  name            = var.az_rg_name
  location        = var.az_location

  tags = var.tags
}

# Create the Azure Key Vault

resource "azurerm_key_vault" "alpinebot_kv" {
  name                        = var.az_kv_name
  location                    = var.az_location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.az_tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true  # Enable Azure RBAC authorization
  
  tags = var.tags
}

# Data block to retrieve the Dev_Admins Azure AD Group
data "azuread_group" "main_admins" {
  display_name = "main_admins"
}

# Data block to retrieve the Key Vault details
data "azurerm_key_vault" "main_kv" {
  name                = var.az_kv_name
  resource_group_name = var.az_rg_name

  depends_on = [ azurerm_key_vault.alpinebot_kv ]
}

# Assign the "Key Vault Secrets Officer" role to the Dev_Admins group using RBAC
resource "azurerm_role_assignment" "main_admins_kv_secrets_officer" {
  scope                = data.azurerm_key_vault.main_kv.id
  role_definition_name = "Key Vault Secrets Officer"  # Predefined role in Azure
  principal_id         = data.azuread_group.main_admins.object_id
}

# Assign the "Key Vault Administrator" role to the Dev_Admins group using RBAC
resource "azurerm_role_assignment" "main_admins_kv_administrator" {
  scope                = data.azurerm_key_vault.main_kv.id
  role_definition_name = "Key Vault Administrator"  # Full admin control over the Key Vault
  principal_id         = data.azuread_group.main_admins.object_id
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

  tags = var.tags
  
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

  tags = var.tags
}

##### Deploy AlpineBot Azure App Service ######

resource "azurerm_linux_web_app" "wap_app" {
  name                = var.wap_website_name
  location            = var.az_location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.wap_sp_website.id
  
  depends_on = [azurerm_cognitive_account.alpinebotaiact, azurerm_service_plan.wap_sp_website]

  tags = var.tags

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
