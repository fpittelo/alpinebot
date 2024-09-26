# Create Azure Cognitive Account (OpenAI)
resource "azurerm_cognitive_account" "alpinebot_openai" {
  name                = var.alpinebotaiact_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  kind                = var.kind
  sku_name            = var.sku_name_cog_acct

  tags = var.tags
}
