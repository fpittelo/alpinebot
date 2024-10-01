resource "azurerm_cosmosdb_account" "db" {
  resource_group_name   = var.az_rg_name
  location              = var.az_location
  name                  = var.az_db_name
  default_identity_type = var.az_db_identity_type
  offer_type            = var.az_db_offer_type
  kind                  = var.az_db_kind
  
  tags = var.tags

  automatic_failover_enabled = true


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