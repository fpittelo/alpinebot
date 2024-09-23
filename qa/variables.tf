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

variable "az_backend_rg_name" {
  description = "Resource group name for the Terraform backend storage"
  type        = string
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

variable "wap_sp_sku_os_linux" {
  description = "value of os type"
  type = string
}

variable "alpinebotaiact" {
  description = "value of OpenAI Account"
  type = string
}

variable "alpinebotaidepl" {
  description = "value of OpenAI Deployment"
  type = string
}

variable "az_openai_key_value" {
  description = "value of OpenAI Key"
  type = string
}

variable "project" {
  description = "value of project"
  type = string
}

variable "owner" {
  description = "value of the owner"
  type = string
}

variable "department" {
  description = "value of department"
  type = string
}

variable "wap_status" {
  description = "Project Status"
  type = string
}

variable "environment" {
  description = "The environment for deployment"
  type        = string
}