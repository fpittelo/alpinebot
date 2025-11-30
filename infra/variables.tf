variable "environment" {
  description = "The environment to deploy to."
  type        = string
  default     = "dev"
}

variable "environments" {
  description = "A map of environment-specific variables."
  type = map(object({
    tags                            = map(string)
    az_location                     = string
    az_backend_sa_name              = string
    az_backend_container_name       = string
    terraform_key                   = string
    az_rg_name                      = string
    az_kv_name                      = string
    wap_sp_name                     = string
    wap_website_name                = string
    wap_sp_sku                      = string
    wap_sp_sku_os_linux             = string
    alpinebotaiact_name             = string
    alpinebotaidepl                 = string
    apbotinsights_name              = string
    appinsights_instrumentation_key = string
    rbac_enabled                    = bool
    kind                            = string
    sku_name_cog_acct               = string
    deployment_sku_name             = string
    auth_enabled                    = bool
    redis_cache_name                = string
    postgresql_server_name          = string
    postgresql_database_name        = string
    log_analytics_workspace_name    = string
    storage_mb                      = number
    function_app_name               = string
    function_storage_account_name   = string
    azure_openai_api_version        = string
    model_name                      = string
    model_version                   = string
    vnet_name                       = string
    vnet_address_space              = list(string)
    subnet_name                     = string
    subnet_prefix                   = list(string)
  }))
  default = {
    "dev" = {
      tags = {
        environment = "dev"
        project     = "AlpineBot"
        owner       = "Fred"
        department  = "IT Department"
      }
      az_location                     = "SwitzerlandNorth"
      az_backend_sa_name              = "devbkdalpinebotsa"
      az_backend_container_name       = "dev-alpinebot-bkd-co"
      terraform_key                   = "dev-alpinebot"
      az_rg_name                      = "dev-alpinebot"
      az_kv_name                      = "dev-alpinebot-vault"
      wap_sp_name                     = "dev-alpinebot-sp"
      wap_website_name                = "dev-alpinebot-as"
      wap_sp_sku                      = "S1"
      wap_sp_sku_os_linux             = "Linux"
      alpinebotaiact_name             = "dev-alpinebot-ai"
      alpinebotaidepl                 = "dev-alpinebot-ai-dpl"
      apbotinsights_name              = "dev-alpinebot-insights"
      appinsights_instrumentation_key = "your-dev-appinsights-key"
      rbac_enabled                    = true
      kind                            = "OpenAI"
      sku_name_cog_acct               = "S0"
      deployment_sku_name             = "GlobalStandard"
      auth_enabled                    = true
      redis_cache_name                = "dev-alpinebot-redis"
      postgresql_server_name          = "dev-alpinebot-psql"
      postgresql_database_name        = "dev-alpinebot-db"
      log_analytics_workspace_name    = "dev-alpinebot-log"
      storage_mb                      = 32768
      function_app_name               = "dev-alpinebot-func"
      function_storage_account_name   = "devalpinebotfuncsa"
      azure_openai_api_version        = "2024-02-15-preview"
      model_name                      = "gpt-4o"
      model_version                   = "2024-05-13"
      vnet_name                       = "dev-alpinebot-vnet"
      vnet_address_space              = ["10.0.0.0/16"]
      subnet_name                     = "dev-alpinebot-subnet"
      subnet_prefix                   = ["10.0.1.0/24"]
    },
    "qa" = {
      tags = {
        environment = "qa"
        project     = "AlpineBot"
        owner       = "Fred"
        department  = "IT Department"
      }
      az_location                     = "SwitzerlandNorth"
      az_backend_sa_name              = "qabkdalpinebotsa"
      az_backend_container_name       = "qa-alpinebot-bkd-co"
      terraform_key                   = "qa-alpinebot"
      az_rg_name                      = "qa-alpinebot"
      az_kv_name                      = "qa-alpinebot-vault"
      wap_sp_name                     = "qa-alpinebot-sp"
      wap_website_name                = "qa-alpinebot-as"
      wap_sp_sku                      = "S1"
      wap_sp_sku_os_linux             = "Linux"
      alpinebotaiact_name             = "qa-alpinebot-ai"
      alpinebotaidepl                 = "qa-alpinebot-ai-dpl"
      apbotinsights_name              = "qa-alpinebot-insights"
      appinsights_instrumentation_key = "your-qa-appinsights-key"
      rbac_enabled                    = true
      kind                            = "OpenAI"
      sku_name_cog_acct               = "S0"
      deployment_sku_name             = "GlobalStandard"
      auth_enabled                    = false
      redis_cache_name                = "qa-alpinebot-redis"
      postgresql_server_name          = "qa-alpinebot-psql"
      postgresql_database_name        = "qa-alpinebot-db"
      log_analytics_workspace_name    = "qa-alpinebot-log"
      storage_mb                      = 32768
      function_app_name               = "qa-alpinebot-func"
      function_storage_account_name   = "qaalpinebotfuncsa"
      azure_openai_api_version        = "2024-08-01-preview"
      model_name                      = "gpt-4o"
      model_version                   = "2024-05-13"
      vnet_name                       = "qa-alpinebot-vnet"
      vnet_address_space              = ["10.1.0.0/16"]
      subnet_name                     = "qa-alpinebot-subnet"
      subnet_prefix                   = ["10.1.1.0/24"]
    },
    "main" = {
      tags = {
        environment = "main"
        project     = "AlpineBot"
        owner       = "Fred"
        department  = "IT Department"
      }
      az_location                     = "SwitzerlandNorth"
      az_backend_sa_name              = "mainbkdalpinebotsa"
      az_backend_container_name       = "main-alpinebot-bkd-co"
      terraform_key                   = "main-alpinebot"
      az_rg_name                      = "main-alpinebot"
      az_kv_name                      = "main-alpinebot-vault"
      wap_sp_name                     = "main-alpinebot-sp"
      wap_website_name                = "main-alpinebot-as"
      wap_sp_sku                      = "S1"
      wap_sp_sku_os_linux             = "Linux"
      alpinebotaiact_name             = "main-alpinebot-ai"
      alpinebotaidepl                 = "main-alpinebot-ai-dpl"
      apbotinsights_name              = "main-alpinebot-insights"
      appinsights_instrumentation_key = "your-main-appinsights-key"
      rbac_enabled                    = true
      kind                            = "OpenAI"
      sku_name_cog_acct               = "S0"
      deployment_sku_name             = "GlobalStandard"
      auth_enabled                    = false
      redis_cache_name                = "main-alpinebot-redis"
      postgresql_server_name          = "main-alpinebot-psql"
      postgresql_database_name        = "main-alpinebot-db"
      log_analytics_workspace_name    = "main-alpinebot-log"
      storage_mb                      = 32768
      function_app_name               = "main-alpinebot-func"
      function_storage_account_name   = "mainalpinebotfuncsa"
      azure_openai_api_version        = "2024-08-01-preview"
      model_name                      = "gpt-4o"
      model_version                   = "2024-05-13"
      vnet_name                       = "main-alpinebot-vnet"
      vnet_address_space              = ["10.2.0.0/16"]
      subnet_name                     = "main-alpinebot-subnet"
      subnet_prefix                   = ["10.2.1.0/24"]
    }
  }
}

variable "az_subscription_id" {
  description = "value of subscription id"
  type        = string
}

variable "az_client_id" {
  description = "The Application (client) ID of the service principal used for authentication."
  type        = string
}

variable "az_tenant_id" {
  description = "The Directory (tenant) ID where the application is registered."
  type        = string
}

variable "sp_object_id" {
  description = "The Object ID of the App Service's Service Principal"
  type        = string
}

variable "postgresql_admin_username" {
  description = "The username of the PostgreSQL server administrator."
  type        = string
}

variable "postgresql_admin_password" {
  description = "The password of the PostgreSQL server administrator."
  type        = string
  sensitive   = true
}

variable "google_client_id" {
  description = "The Client ID for Google OAuth."
  type        = string
  sensitive   = true
}

variable "google_client_secret" {
  description = "The Client Secret for Google OAuth."
  type        = string
  sensitive   = true
}








variable "client_ip_address" {
  description = "The IP address of the client (e.g., GitHub Actions runner) to allow access to Key Vault."
  type        = string
  default     = null
}
