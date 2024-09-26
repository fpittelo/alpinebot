variable "wap_sp_name" {
  description = "Service plan name"
  type        = string
}

variable "wap_sp_sku" {
  description = "Service plan SKU"
  type        = string
}

variable "wap_sp_sku_os_linux" {
  description = "Service plan OS type (Linux)"
  type        = string
}

variable "az_location" {
  description = "Location for the resources"
  type        = string
}

variable "az_rg_name" {
  description = "Resource group for project"
  type        = string
}

variable "tags" {
  description = "Tags to apply to App Service resources"
  type        = map(string)
}
