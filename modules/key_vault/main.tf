resource "azurerm_key_vault" "alpinebot_kv" {
  name                        = var.az_kv_name
  location                    = var.location
  resource_group_name         = var.az_rg_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  purge_protection_enabled    = var.purge_protection_enabled
  enable_rbac_authorization   = var.enable_rbac_authorization

  tags = var.tags
}
