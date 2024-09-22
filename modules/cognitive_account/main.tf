# Create Azure Cognitive Account (OpenAI)
resource "azurerm_cognitive_account" "alpinebot_openai" {
  name                = var.alpinebot_openai_name
  location            = var.location
  resource_group_name = var.az_rg_name
  kind                = "OpenAI"
  sku_name            = "S0"

  tags = var.tags
}
