locals {
  # Use the az_rg_name from the environment map
  environment_vars = var.environments[var.environment]
}

#### Creation of Azure infra ##########
#######################################

#### Create Azure Resource Group ######
resource "azurerm_resource_group" "rg" {
  name     = local.environment_vars.az_rg_name
  location = local.environment_vars.az_location
  tags     = local.environment_vars.tags
}

#### Create Virtual Network and Subnet ######
module "virtual_network" {
  source             = "../modules/virtual_network"
  vnet_name          = local.environment_vars.vnet_name
  az_location        = local.environment_vars.az_location
  az_rg_name         = local.environment_vars.az_rg_name
  vnet_address_space = local.environment_vars.vnet_address_space
  subnet_name        = local.environment_vars.subnet_name
  subnet_prefix      = local.environment_vars.subnet_prefix
  tags               = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

#### Create the Azure Key Vault #####



module "key_vault" {
  source = "../modules/key_vault"

  az_rg_name                  = local.environment_vars.az_rg_name
  az_kv_name                  = local.environment_vars.az_kv_name
  az_location                 = local.environment_vars.az_location
  tenant_id                   = var.az_tenant_id
  enabled_for_disk_encryption = false
  purge_protection_enabled    = false
  enable_rbac_authorization   = true

  depends_on = [azurerm_resource_group.rg]

  tags = local.environment_vars.tags

  key_vault_ip_rules = [
    for ip in [var.client_ip_address, "83.76.0.0/14"] : ip if ip != null
  ]

  key_vault_subnet_ids = [
    module.virtual_network.subnet_id
  ]
}



# Get the current service principal/client object ID
data "azurerm_client_config" "current" {}

# Assign Key Vault Secrets Officer role to the current service principal
resource "azurerm_role_assignment" "key_vault_secrets_officer" {
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id

  depends_on = [module.key_vault]
}

# Look up the user to grant access to
data "azuread_user" "admin_user" {
  user_principal_name = "frederic.pitteloud@fpittelo.ch"
}

# Assign Key Vault Administrator role to the user
resource "azurerm_role_assignment" "key_vault_admin_user" {
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azuread_user.admin_user.object_id

  depends_on = [module.key_vault]
}

resource "azurerm_key_vault_secret" "openai_key" {
  name         = "openai-api-key"
  value        = module.cognitive_account.openai_key
  key_vault_id = module.key_vault.key_vault_id

  depends_on = [
    module.key_vault,
    module.cognitive_account,
    azurerm_role_assignment.key_vault_secrets_officer
  ]
}

#### Deploy AlpineBot OpenAI Account ######
module "cognitive_account" {
  source              = "../modules/cognitive_account"
  alpinebotaiact_name = local.environment_vars.alpinebotaiact_name
  az_location         = local.environment_vars.az_location
  az_rg_name          = local.environment_vars.az_rg_name
  kind                = local.environment_vars.kind
  sku_name_cog_acct     = local.environment_vars.sku_name_cog_acct
  tags                  = local.environment_vars.tags
  model_deployment_name = local.environment_vars.alpinebotaidepl
  model_name            = local.environment_vars.model_name
  model_version         = local.environment_vars.model_version

  depends_on = [azurerm_resource_group.rg]
}

### Creation of Azure Service Plan #########
module "app_service_plan" {
  source              = "../modules/app_service_plan"
  wap_sp_name         = local.environment_vars.wap_sp_name
  az_location         = local.environment_vars.az_location
  az_rg_name          = local.environment_vars.az_rg_name
  wap_sp_sku          = local.environment_vars.wap_sp_sku
  wap_sp_sku_os_linux = local.environment_vars.wap_sp_sku_os_linux
  tags                = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

##### Deploy AlpineBot Linux Web App ######
module "linux_web_app" {
  source                            = "../modules/linux_web_app"
  wap_website_name                  = local.environment_vars.wap_website_name
  service_plan_id                   = module.app_service_plan.service_plan_id
  wap_sp_name                       = local.environment_vars.wap_sp_name
  az_rg_name                        = local.environment_vars.az_rg_name
  az_location                       = local.environment_vars.az_location
  auth_enabled                      = local.environment_vars.auth_enabled
  google_client_id                  = var.google_client_id
  google_client_secret_setting_name = "GOOGLE_CLIENT_SECRET"

  app_settings = {
    "GOOGLE_CLIENT_SECRET" = var.google_client_secret
    "REDIS_HOST"           = module.redis_cache.hostname
    "REDIS_PORT"           = module.redis_cache.port
    "REDIS_PASSWORD"       = module.redis_cache.primary_key
    "POSTGRES_HOST"        = module.postgresql_db.fqdn
    "POSTGRES_DB"          = module.postgresql_db.database_name
    "POSTGRES_USER"        = var.postgresql_admin_username
    "POSTGRES_PASSWORD"    = var.postgresql_admin_password
  }

  tags = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

##### Deploy Redis Cache and PostgreSQL Database ######
module "redis_cache" {
  source               = "../modules/redis_cache"
  redis_cache_name     = local.environment_vars.redis_cache_name
  az_location          = local.environment_vars.az_location
  az_rg_name           = local.environment_vars.az_rg_name
  redis_cache_sku_name = "Basic"
  redis_cache_family   = "C"
  redis_cache_capacity = 0
  tags                 = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

module "postgresql_db" {
  source                    = "../modules/postgresql_db"
  postgresql_server_name    = local.environment_vars.postgresql_server_name
  az_location               = local.environment_vars.az_location
  az_rg_name                = local.environment_vars.az_rg_name
  postgresql_admin_username = var.postgresql_admin_username
  postgresql_admin_password = var.postgresql_admin_password
  postgresql_database_name  = local.environment_vars.postgresql_database_name
  storage_mb                = local.environment_vars.storage_mb
  tags                      = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

#### Deploy Log Analytics Workspace #####
module "log_analytics_workspace" {
  source                                    = "../modules/log_analytics_workspace"
  log_analytics_workspace_name              = local.environment_vars.log_analytics_workspace_name
  az_location                               = local.environment_vars.az_location
  az_rg_name                                = local.environment_vars.az_rg_name
  log_analytics_workspace_sku               = "PerGB2018" # Default SKU
  log_analytics_workspace_retention_in_days = 30          # Default retention
  tags                                      = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

#### Deploy App Insights #####
resource "azurerm_application_insights" "apbotinsights" {
  name                = local.environment_vars.apbotinsights_name
  location            = local.environment_vars.az_location
  resource_group_name = local.environment_vars.az_rg_name
  application_type    = "web"
  workspace_id        = module.log_analytics_workspace.log_analytics_workspace_id

  depends_on = [azurerm_resource_group.rg, module.log_analytics_workspace]
}

#### Deploy Azure Function App ######
module "function_app" {
  source = "../modules/function_app"

  function_app_name              = local.environment_vars.function_app_name
  storage_account_name           = local.environment_vars.function_storage_account_name
  az_location                    = local.environment_vars.az_location
  az_rg_name                     = local.environment_vars.az_rg_name
  service_plan_id                = module.app_service_plan.service_plan_id
  app_insights_connection_string = azurerm_application_insights.apbotinsights.connection_string
  virtual_network_subnet_id      = module.virtual_network.subnet_id

  app_settings = {
    "AZURE_OPENAI_API_KEY"         = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.openai_key.id})"
    "AZURE_OPENAI_ENDPOINT"        = module.cognitive_account.cognitive_account_endpoint
    "AZURE_OPENAI_DEPLOYMENT_NAME" = local.environment_vars.alpinebotaidepl
    "AZURE_OPENAI_API_VERSION"     = local.environment_vars.azure_openai_api_version
  }

  cors_allowed_origins = [
    "https://${local.environment_vars.wap_website_name}.azurewebsites.net"
  ]

  tags = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg, module.app_service_plan, azurerm_application_insights.apbotinsights]
}

resource "azurerm_role_assignment" "kv_access_for_function" {
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.function_app.principal_id

  depends_on = [module.key_vault, module.function_app]
}

output "instrumentation_key" {
  value     = azurerm_application_insights.apbotinsights.instrumentation_key
  sensitive = true # Mark as sensitive
}

output "app_id" {
  value = azurerm_application_insights.apbotinsights.app_id
}
