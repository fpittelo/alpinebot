variable "function_app_name" {
  description = "Name of the Azure Function App"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for the Function App"
  type        = string
}

variable "az_location" {
  description = "Azure region for the Function App"
  type        = string
}

variable "az_rg_name" {
  description = "Resource group name"
  type        = string
}

variable "service_plan_id" {
  description = "ID of the App Service Plan for the Function App"
  type        = string
}

variable "app_settings" {
  description = "Application settings for the Function App"
  type        = map(string)
  default     = {}
}

variable "cors_allowed_origins" {
  description = "List of allowed CORS origins"
  type        = list(string)
  default     = ["*"]
}

variable "app_insights_connection_string" {
  description = "Application Insights connection string"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Function App resources"
  type        = map(string)
}
