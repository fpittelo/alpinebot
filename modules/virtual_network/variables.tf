variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "az_location" {
  description = "Location of the Virtual Network"
  type        = string
}

variable "az_rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "Address prefix for the Subnet"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "service_endpoints" {
  description = "List of Service Endpoints to associate with the subnet"
  type        = list(string)
}
