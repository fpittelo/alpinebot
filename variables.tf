#### Variables ######

variable "az_tenant_id" {
  description = "value of subscription id"
  type = string
}

variable "az_subscription_id" {
  description = "value of subscription id"
  type = string
}

variable "az_client_id" {
  description = "value of subscription id"
  type = string
}

variable "az_sp_object_id" {
  description = "The Object ID of the App Service's Service Principal"
  type        = string
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

variable "terraform_key" {
  description = "value of terraform state file name"
  type = string
}

variable "az_rg_name" {
  description = "value of resource group name"
  type = string
}

variable "location" {
  description = "value of resource group location"
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

variable "status" {
  description = "Project Status"
  type = string
}

variable "environment" {
  description = "The environment for deployment"
  type        = string
}

variable "az_openai_key_name" {
  description = "Name of the OpenAI key stored in Key Vault"
  type        = string
}

variable "az_openai_key_value" {
  description = "OpenAI key value stored in Key Vault"
  type        = string
}