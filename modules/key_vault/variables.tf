variable "az_kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "az_location" {
  description = "Location for Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which to create the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for Azure"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Key Vault resources"
  type        = map(string)
}