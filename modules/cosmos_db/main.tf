resource "azurerm_cosmosdb_account" "db" {
  name                = var.az_db_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  offer_type          = var.offer_type
  kind                = var.db_kind
  
  tags = var.tags

  automatic_failover_enabled = true
  
  identity {
    type = var.db_identity_type
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = "SwitzerlandNorth"
    failover_priority = 1
  }

  geo_location {
    location          = "SwitzerlandWest"
    failover_priority = 1
  }
}