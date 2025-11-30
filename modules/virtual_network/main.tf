resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.az_location
  resource_group_name = var.az_rg_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.az_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix

  service_endpoints = [
    "Microsoft.KeyVault",
    "Microsoft.Web"
  ]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
