variable "az_rg_name" {
  description = "Resource Group Name for Key Vault"
  type        = string
}

variable "az_kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "az_location" {
  description = "Location for Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for Azure"
  type        = string
}

variable "enabled_for_disk_encryption" {
  description = "Whether to enable disk encryption"
  type        = bool
  default     = false  # Set a default value if appropriate
}

variable "purge_protection_enabled" {
  description = "Whether to enable purge protection"
  type        = bool
  default     = true  # Set a default value if appropriate
}

variable "enable_rbac_authorization" {
  description = "Whether to enable RBAC authorization"
  type        = bool
  default     = true  # Set a default value if appropriate
}

variable "tags" {
  description = "Tags to apply to Key Vault resources"
  type        = map(string)
  default     = {}  # Set default to empty map if appropriate
}