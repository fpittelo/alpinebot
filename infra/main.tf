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
}

#### Deploy AlpineBot OpenAI Account ######
module "cognitive_account" {
  source              = "../modules/cognitive_account"
  alpinebotaiact_name = local.environment_vars.alpinebotaiact_name
  az_location         = local.environment_vars.az_location
  az_rg_name          = local.environment_vars.az_rg_name
  kind                = local.environment_vars.kind
  sku_name_cog_acct   = local.environment_vars.sku_name_cog_acct
  tags                = local.environment_vars.tags

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
  source                         = "../modules/linux_web_app"
  wap_website_name               = local.environment_vars.wap_website_name
  service_plan_id                = module.app_service_plan.service_plan_id
  wap_sp_name                    = local.environment_vars.wap_sp_name
  az_rg_name                     = local.environment_vars.az_rg_name
  az_location                    = local.environment_vars.az_location
  auth_enabled                   = local.environment_vars.auth_enabled
  google_client_id               = local.environment_vars.google_client_id
  google_client_secret_setting_name = "GOOGLE_CLIENT_SECRET"
  microsoft_client_id            = local.environment_vars.microsoft_client_id
  microsoft_client_secret_setting_name = "MICROSOFT_CLIENT_SECRET"

  app_settings = {
    "GOOGLE_CLIENT_SECRET"    = local.environment_vars.google_client_secret
    "MICROSOFT_CLIENT_SECRET" = local.environment_vars.microsoft_client_secret
    "REDIS_HOST"              = module.redis_cache.hostname
    "REDIS_PORT"              = module.redis_cache.port
    "REDIS_PASSWORD"          = module.redis_cache.primary_key
  }

  tags = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

##### Deploy CosmosDB Database ######
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
  tags                      = local.environment_vars.tags

  depends_on = [azurerm_resource_group.rg]
}

#### Deploy Log Analytics Workspace #####
module "log_analytics_workspace" {
  source                          = "../modules/log_analytics_workspace"
  log_analytics_workspace_name    = local.environment_vars.log_analytics_workspace_name
  az_location                     = local.environment_vars.az_location
  az_rg_name                      = local.environment_vars.az_rg_name
  log_analytics_workspace_sku     = "PerGB2018" # Default SKU
  log_analytics_workspace_retention_in_days = 30 # Default retention
  tags                            = local.environment_vars.tags

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

output "instrumentation_key" {
  value = azurerm_application_insights.apbotinsights.instrumentation_key
  sensitive = true  # Mark as sensitive
}

output "app_id" {
  value = azurerm_application_insights.apbotinsights.app_id
}
