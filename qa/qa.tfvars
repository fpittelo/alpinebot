#### Variables values ####

tags  = {
  environment                       = "qa"
  project                           = "AlpineBot"
  owner                             = "Fred"
  department                        = "IT Department"
}

az_location                         = "SwitzerlandNorth"

az_backend_sa_name                  = "qabkdalpinebotsa"
az_backend_container_name           = "qa-alpinebot-bkd-co"
terraform_key                       = "qa-alpinebot"

az_rg_name                          = "qa-alpinebot"
az_kv_name                          = "qa-alpinebot-vault"

wap_sp_name                         = "qa-alpinebot-sp"
wap_website_name                    = "qa-alpinebot-as"
wap_sp_sku                          = "S1"
wap_sp_sku_os_linux                 = "Linux"

alpinebotaiact_name                 = "qa-alpinebot-ai"
alpinebotaidepl                     = "qa-alpinebot-ai-dpl"

apbotinsights_name                  = "qa-alpinebot-insights"
appinsights_instrumentation_key     = "your-qa-appinsights-key"

rbac_enabled                        = true

kind                                = "OpenAI"
sku_name_cog_acct                   = "S0"