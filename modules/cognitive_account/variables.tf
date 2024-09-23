
variable "alpinebotaiact_name" {
  description = "Name of the Azure Cognitive Account (OpenAI)"
  type        = string
}

variable "location" {
  description = "Location"
  type = string
}

variable "az_rg_name" {
  description = "value of resource group name"
  type = string
}

variable "tags" {
  description = "Tags to apply to Cognitive Account"
  type        = map(string)
}

variable "kind" {
  description = "value of kind"
  type = string
}

variable "sku_name_cog_acct" {
  description = "value of sku name"
  type = string
}

variable "tags" {
  description = "value of tags"
  type = map(string)
}