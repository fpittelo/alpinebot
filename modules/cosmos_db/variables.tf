#### Modules Variables ######

variable "az_db_name" {
  description = "Service plan name"
  type        = string
}

variable "az_location" {
  description = "location"
  type        = string
}

variable "az_rg_name" {
  description = "resource_group_name"
  type        = string
}

variable "offer_type" {
  description = "offer_type"
  type        = string
}

variable "db_kind" {
  description = "kind"
  type        = string
}

variable "db_identity_type" {
  type        = string
  default     = "None"
  description = "Type of managed identity (e.g., UserAssigned, SystemAssigned)."
}

variable "tags" {
  description = "tags"
  type        = map(string)
}