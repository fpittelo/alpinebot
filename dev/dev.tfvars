#### Variables values ####

tags  = {
  environment                         = "dev"
  project                             = "AlpineBot"
  owner                               = "Fred"
  department                          = "IT Department"
}

location                            = "SwitzerlandNorth"

az_backend_sa_name                  = "devbkdalpinebotsa"
az_backend_container_name           = "dev-alpinebot-bkd-co"
terraform_key                       = "dev-alpinebot"

az_rg_name                          = "dev-alpinebot"
az_kv_name                          = "dev-alpinebot-vault"

wap_sp_name                         = "dev-alpinebot-sp"
wap_website_name                    = "dev-alpinebot-as"
wap_sp_sku                          = "S1"
wap_sp_sku_os_linux                 = "Linux"

alpinebotaiact_name                 = "dev-alpinebot-ai"
alpinebotaidepl                     = "dev-alpinebot-ai-dpl"

apbotinsights_name                  = "dev-alpinebot-insights"
appinsights_instrumentation_key     = "your-dev-appinsights-key"

rbac_enabled                        = true

kind                                = "OpenAI"
sku_name_cog_acct                   = "S0"