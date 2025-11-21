variable "environment" {
  description = "The environment to deploy to."
  type        = string
  default     = "dev"
}

variable "environments" {
  description = "A map of environment-specific variables."
  type = map(object({
    tags = map(string)
    az_location = string
    az_backend_sa_name = string
    az_backend_container_name = string
    terraform_key = string
    az_rg_name = string
    az_kv_name = string
    wap_sp_name = string
    wap_website_name = string
    wap_sp_sku = string
    wap_sp_sku_os_linux = string
    alpinebotaiact_name = string
    alpinebotaidepl = string
    apbotinsights_name = string
    appinsights_instrumentation_key = string
    rbac_enabled = bool
    kind = string
    sku_name_cog_acct = string
    auth_enabled = bool
    google_client_id = string
    google_client_secret = string
    microsoft_client_id = string
    microsoft_client_secret = string
    redis_cache_name = string
    postgresql_server_name = string
    postgresql_database_name = string
  }))
  default = {
    "dev" = {
      tags = {
        environment = "dev"
        project     = "AlpineBot"
        owner       = "Fred"
        department  = "IT Department"
      }
      az_location = "SwitzerlandNorth"
      az_backend_sa_name = "devbkdalpinebotsa"
      az_backend_container_name = "dev-alpinebot-bkd-co"
      terraform_key = "dev-alpinebot"
      az_rg_name = "dev-alpinebot"
      az_kv_name = "dev-alpinebot-vault"
      wap_sp_name = "dev-alpinebot-sp"
      wap_website_name = "dev-alpinebot-as"
      wap_sp_sku = "S1"
      wap_sp_sku_os_linux = "Linux"
      alpinebotaiact_name = "dev-alpinebot-ai"
      alpinebotaidepl = "dev-alpinebot-ai-dpl"
      apbotinsights_name = "dev-alpinebot-insights"
      appinsights_instrumentation_key = "your-dev-appinsights-key"
      rbac_enabled = true
      kind = "OpenAI"
      sku_name_cog_acct = "S0"
      auth_enabled = true
      google_client_id = "your-google-client-id"
      google_client_secret = "your-google-client-secret"
      microsoft_client_id = "your-microsoft-client-id"
      microsoft_client_secret = "your-microsoft-client-secret"
      redis_cache_name = "dev-alpinebot-redis"
      postgresql_server_name = "dev-alpinebot-psql"
      postgresql_database_name = "dev-alpinebot-db"
    },
    "qa" = {
      tags = {
        environment = "qa"
        project     = "AlpineBot"
        owner       = "Fred"
        department  = "IT Department"
      }
      az_location = "SwitzerlandNorth"
      az_backend_sa_name = "qabkdalpinebotsa"
      az_backend_container_name = "qa-alpinebot-bkd-co"
      terraform_key = "qa-alpinebot"
      az_rg_name = "qa-alpinebot"
      az_kv_name = "qa-alpinebot-vault"
      wap_sp_name = "qa-alpinebot-sp"
      wap_website_name = "qa-alpinebot-as"
      wap_sp_sku = "S1"
      wap_sp_sku_os_linux = "Linux"
      alpinebotaiact_name = "qa-alpinebot-ai"
      alpinebotaidepl = "qa-alpinebot-ai-dpl"
      apbotinsights_name = "qa-alpinebot-insights"
      appinsights_instrumentation_key = "your-qa-appinsights-key"
      rbac_enabled = true
      kind = "OpenAI"
      sku_name_cog_acct = "S0"
      auth_enabled = false
      google_client_id = ""
      google_client_secret = ""
      microsoft_client_id = ""
      microsoft_client_secret = ""
      redis_cache_name = "qa-alpinebot-redis"
      postgresql_server_name = "qa-alpinebot-psql"
      postgresql_database_name = "qa-alpinebot-db"
    },
    "main" = {
      tags = {
        environment = "main"
        project     = "AlpineBot"
        owner       = "Fred"
        department  = "IT Department"
      }
      az_location = "SwitzerlandNorth"
      az_backend_sa_name = "mainbkdalpinebotsa"
      az_backend_container_name = "main-alpinebot-bkd-co"
      terraform_key = "main-alpinebot"
      az_rg_name = "main-alpinebot"
      az_kv_name = "main-alpinebot-vault"
      wap_sp_name = "main-alpinebot-sp"
      wap_website_name = "main-alpinebot-as"
      wap_sp_sku = "S1"
      wap_sp_sku_os_linux = "Linux"
      alpinebotaiact_name = "main-alpinebot-ai"
      alpinebotaidepl = "main-alpinebot-ai-dpl"
      apbotinsights_name = "main-alpinebot-insights"
      appinsights_instrumentation_key = "your-main-appinsights-key"
      rbac_enabled = true
      kind = "OpenAI"
      sku_name_cog_acct = "S0"
      auth_enabled = false
      google_client_id = ""
      google_client_secret = ""
      microsoft_client_id = ""
      microsoft_client_secret = ""
      redis_cache_name = "main-alpinebot-redis"
      postgresql_server_name = "main-alpinebot-psql"
      postgresql_database_name = "main-alpinebot-db"
    }
  }
}

variable "az_subscription_id" {
  description = "value of subscription id"
  type        = string
}

variable "az_client_id" {
  description = "value of subscription id"
  type        = string
}

variable "az_tenant_id" {
  description = "value of subscription id"
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
