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

variable "az_db_kind" {
  description = "DB Kind"
  type        = string
}

variable "az_db_offer_type" {
  description = "DB Offer Type"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}