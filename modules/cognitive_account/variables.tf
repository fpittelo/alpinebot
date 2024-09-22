variable "alpinebot_openai_name" {
  description = "Name of the Azure Cognitive Account (OpenAI)"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "az_rg_name" {
  description = "Resource group for OpenAI account"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Cognitive Account"
  type        = map(string)
}
