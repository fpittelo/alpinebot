variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}

variable "az_location" {
  description = "The Azure region where the Log Analytics Workspace will be created."
  type        = string
}

variable "az_rg_name" {
  description = "The name of the resource group in which the Log Analytics Workspace will be created."
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "The SKU of the Log Analytics Workspace. Possible values are Free, Standard, Premium, PerNode, PerGB2018, Standalone, Unlimited."
  type        = string
  default     = "PerGB2018" # Recommended for most production scenarios
}

variable "log_analytics_workspace_retention_in_days" {
  description = "The number of days to retain logs for in the Log Analytics Workspace. Possible values are between 7 and 730."
  type        = number
  default     = 30
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
