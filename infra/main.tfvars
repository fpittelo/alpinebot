#### Variables values ####

tags  = {
  environment                       = "main"
  project                           = "AlpineBot"
  owner                             = "Fred"
  department                        = "IT Department"
}

az_location                         = "SwitzerlandNorth"

az_backend_sa_name                  = "mainbkdalpinebotsa"
az_backend_container_name           = "main-alpinebot-bkd-co"
terraform_key                       = "main-alpinebot"

az_rg_name                          = "main-alpinebot"
az_kv_name                          = "main-alpinebot-vault"

wap_sp_name                         = "main-alpinebot-sp"
wap_website_name                    = "main-alpinebot-as"
wap_sp_sku                          = "S1"
wap_sp_sku_os_linux                 = "Linux"

alpinebotaiact_name                 = "main-alpinebot-ai"
alpinebotaidepl                     = "main-alpinebot-ai-dpl"

az_db_name                          = "main-alpinebot-db"
az_db_kind                          = "MongoDB"
az_db_offer_type                    = "Standard"

apbotinsights_name                  = "main-alpinebot-insights"
appinsights_instrumentation_key     = "your-main-appinsights-key"

rbac_enabled                        = true

kind                                = "OpenAI"
sku_name_cog_acct                   = "S0"