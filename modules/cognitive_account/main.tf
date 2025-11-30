# Create Azure Cognitive Account (OpenAI)
resource "azurerm_cognitive_account" "alpinebot_openai" {
  name                = var.alpinebotaiact_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  kind                = var.kind
  sku_name            = var.sku_name_cog_acct

  tags = var.tags
}

resource "azurerm_cognitive_deployment" "openai_deployment" {
  name                 = var.model_deployment_name
  cognitive_account_id = azurerm_cognitive_account.alpinebot_openai.id
  model {
    format  = "OpenAI"
    name    = var.model_name
    version = var.model_version
  }

  sku {
    name     = "Standard"
    capacity = 10
  }
}
