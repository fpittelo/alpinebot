variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "az_location" {
  description = "The Azure region where the PostgreSQL server will be created."
  type        = string
}

variable "az_rg_name" {
  description = "The name of the resource group in which the PostgreSQL server will be created."
  type        = string
}

variable "postgresql_sku_name" {
  description = "The SKU of the PostgreSQL server."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "postgresql_version" {
  description = "The version of the PostgreSQL server."
  type        = string
  default     = "13"
}

variable "postgresql_admin_username" {
  description = "The username of the PostgreSQL server administrator."
  type        = string
}

variable "postgresql_admin_password" {
  description = "The password of the PostgreSQL server administrator."
  type        = string
  sensitive   = true
}

variable "postgresql_database_name" {
  description = "The name of the PostgreSQL database."
  type        = string
  default     = "postgres"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
