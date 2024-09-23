#### Variables values ####

tags  = {
  environment                         = "dev"
  project                             = "AlpineBot"
  owner                               = "Fred"
  department                          = "IT Department"
}

location                            = "SwitzerlandNorth"

az_backend_sa_name                  = "devbkdalpinebotsa"
az_backend_container_name           = "dev-bkd-alpinebot-co"
terraform_key                       = "dev-terraform-state"

az_rg_name                          = "dev-alpinebot-rg"
az_kv_name                          = "dev-alpinebot-kv"

wap_sp_name                         = "dev-alpinebot-sp"
wap_website_name                    = "dev-alpinebot-as"
wap_sp_sku                          = "S1"
wap_sp_sku_os_linux                 = "Linux"

alpinebotaiact_name                 = "dev-alpinebot-act"
alpinebotaidepl                     = "dev-alpinebot-dpl"

apbotinsights_name                  = "dev-apbotinsights"
appinsights_instrumentation_key     = "your-dev-appinsights-key"

rbac_enabled                        = true

kind                                = "OpenAI"
sku_name_cog_acct                   = "S0"