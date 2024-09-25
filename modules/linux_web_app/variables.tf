
variable "wap_website_name" {
  description = "Web app name"
  type        = string
}

variable "az_rg_name" {
  description = "Resource group for project"
  type        = string
}

variable "az_location" {
  description = "Location for the resources"
  type        = string
}

variable "wap_sp_name" {
  description = "value of service plan id"
  type        = string
}

variable "service_plan_id" {
  description = "value of service plan id"
  type        = string
}

variable "app_settings" {
  description = "Application settings for the Linux Web App."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "value of tags"
  type        = map(string)
}