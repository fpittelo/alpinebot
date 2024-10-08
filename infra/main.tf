#### Creation of Azure infra ##########
#######################################

#### Create Azure Resource Group ######
resource "azurerm_resource_group" "rg" {
  name            = var.az_rg_name
  location        = var.az_location

  tags            = var.tags
}

#### Create the Azure Key Vault #####
module "key_vault" {
  source              = "../modules/key_vault"

  az_rg_name          = var.az_rg_name          # From root module variables
  az_kv_name          = var.az_kv_name          # From root module variables
  az_location         = var.az_location            # From root module variables
  tenant_id           = var.az_tenant_id        # From root module variables
  
  enabled_for_disk_encryption = false           # Set to true or false as needed
  purge_protection_enabled    = false           # Set to true or false as needed
  enable_rbac_authorization   = true            # Set to true or false as needed
  
  depends_on = [ azurerm_resource_group.rg ]

  tags                = var.tags                # From root module variables
}

#### Deploy AlpineBot OpenAI Account ######
module "cognitive_account" {
  source              = "../modules/cognitive_account"
  alpinebotaiact_name = var.alpinebotaiact_name
  az_location         = var.az_location
  az_rg_name          = var.az_rg_name
  kind                = var.kind
  sku_name_cog_acct   = var.sku_name_cog_acct

  tags = var.tags

   depends_on = [ azurerm_resource_group.rg ]
}

### Creation of Azure Service Plan #########
module "app_service_plan" {
  source              = "../modules/app_service_plan"
  wap_sp_name         = var.wap_sp_name
  az_location         = var.az_location
  az_rg_name          = var.az_rg_name
  wap_sp_sku          = var.wap_sp_sku
  wap_sp_sku_os_linux = var.wap_sp_sku_os_linux

  tags = var.tags

  depends_on = [ azurerm_resource_group.rg ]
}

##### Deploy AlpineBot Linux Web App ######
module "linux_web_app" {
  source              = "../modules/linux_web_app"
  wap_website_name    = var.wap_sp_name
  service_plan_id     = module.app_service_plan.service_plan_id
  wap_sp_name         = var.wap_sp_name
  az_rg_name          = var.az_rg_name
  az_location         = var.az_location
  
  tags = var.tags  

  depends_on = [ azurerm_resource_group.rg ]
}

##### Deploy CosmosDB Database ######
module "azurerm_cosmosdb_account" {
  source              = "../modules/cosmos_db"
  az_rg_name          = var.az_rg_name
  az_location         = var.az_location
  az_db_name          = var.az_db_name
  az_db_kind          = var.az_db_kind
  az_db_offer_type    = var.az_db_offer_type
  
  tags                = var.tags

  depends_on = [ azurerm_resource_group.rg ]
}

#### Deploy App Insights #####
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