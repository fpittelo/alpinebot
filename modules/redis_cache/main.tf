resource "azurerm_redis_cache" "redis" {
  name                = var.redis_cache_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  capacity            = var.redis_cache_capacity
  family              = var.redis_cache_family
  sku_name            = var.redis_cache_sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  tags                = var.tags
}
