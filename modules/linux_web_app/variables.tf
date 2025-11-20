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

variable "auth_enabled" {
  description = "Enable authentication"
  type        = bool
  default     = false
}

variable "google_client_id" {
  description = "Google client ID"
  type        = string
  default     = ""
}

variable "google_client_secret_setting_name" {
  description = "Google client secret setting name"
  type        = string
  default     = ""
}

variable "microsoft_client_id" {
  description = "Microsoft client ID"
  type        = string
  default     = ""
}

variable "microsoft_client_secret_setting_name" {
  description = "Microsoft client secret setting name"
  type        = string
  default     = ""
}