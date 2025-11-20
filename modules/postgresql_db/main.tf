resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                   = var.postgresql_server_name
  location               = var.az_location
  resource_group_name    = var.az_rg_name
  version                = var.postgresql_version
  sku_name               = var.postgresql_sku_name
  administrator_login    = var.postgresql_admin_username
  administrator_password = var.postgresql_admin_password
  storage_mb             = 32768
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = var.postgresql_database_name
  server_id = azurerm_postgresql_flexible_server.postgresql.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
