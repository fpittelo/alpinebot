
variable "alpinebotaiact_name" {
  description = "Name of the Azure Cognitive Account (OpenAI)"
  type        = string
}

variable "az_location" {
  description = "Location"
  type        = string
}

variable "az_rg_name" {
  description = "value of resource group name"
  type        = string
}

variable "kind" {
  description = "value of kind"
  type        = string
}

variable "sku_name_cog_acct" {
  description = "value of sku name"
  type        = string
}

variable "tags" {
  description = "value of tags"
  type        = map(string)
}

variable "model_deployment_name" {
  description = "Name of the OpenAI model deployment"
  type        = string
}

variable "model_name" {
  description = "Name of the OpenAI model (e.g., gpt-4)"
  type        = string
}

variable "model_version" {
  description = "Version of the OpenAI model"
  type        = string
}

variable "deployment_sku_name" {
  description = "SKU name for the OpenAI deployment (e.g., Standard, GlobalStandard)"
  type        = string
  default     = "GlobalStandard"
}