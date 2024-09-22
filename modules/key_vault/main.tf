# Create Azure Key Vault
resource "azurerm_key_vault" "alpinebot_kv" {
  name                        = var.az_kv_name
  location                    = var.az_location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true

  tags = var.tags
}