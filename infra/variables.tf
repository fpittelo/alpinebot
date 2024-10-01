#### Variables ######

variable "az_subscription_id" {
  description = "value of subscription id"
  type = string
}

variable "az_client_id" {
  description = "value of subscription id"
  type = string
}

variable "az_tenant_id" {
  description = "value of subscription id"
  type = string
}

variable "az_backend_sa_name" {
  description = "Storage account name for the Terraform backend"
  type        = string
}

variable "az_backend_container_name" {
  description = "value of container name"
  type = string
}

variable "az_rg_name" {
  description = "value of resource group name"
  type = string
}

variable "az_kv_name" {
  description = "value of Key Vault name"
  type = string
}

variable "terraform_key" {
  description = "value of terraform state file name"
  type = string
}

variable "az_location" {
  description = "value of resource group location"
  type = string
}

variable "apbotinsights_name" {
  type = string
}

variable "wap_sp_name" {
  type = string
}

variable "wap_website_name" {
  description = "The name of the App Service"
  type        = string
}

variable "sp_object_id" {
  description = "The Object ID of the App Service's Service Principal"
  type        = string
}

variable "wap_sp_sku" {
  description = "value of sku name"
  type = string
}

variable "kind" {
  description = "value of kind"
  type = string
}

variable "az_db_kind" {
  description = "value of kind"
  type = string
}

variable "az_db_offer_type" {
  description = "DB Kind"
  type        = string
}

variable "az_db_name" {
  description = "value of kind"
  type = string
}

variable "wap_sp_sku_os_linux" {
  description = "value of os type"
  type = string
}

variable "alpinebotaiact_name" {
  description = "value of OpenAI Account"
  type = string
}

variable "alpinebotaidepl" {
  description = "value of OpenAI Deployment"
  type = string
}

variable "sku_name_cog_acct" {
  description = "value of sku name"
  type = string
}

variable "rbac_enabled" {
  description = "value of RBAC enabled"
  type = string
}

variable "appinsights_instrumentation_key" {
  description = "value of instrumentation key"
  type = string
}

variable "tags" {
  description = "Tags to apply to Key Vault resources"
  type        = map(string)
  default     = {}  # Set default to empty map if appropriate
}