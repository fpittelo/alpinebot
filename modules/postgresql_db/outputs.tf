output "fqdn" {
  value = azurerm_postgresql_flexible_server.postgresql.fqdn
}

output "database_name" {
  value = azurerm_postgresql_flexible_server_database.database.name
}
