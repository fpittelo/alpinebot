variable "redis_cache_name" {
  description = "The name of the Redis cache."
  type        = string
}

variable "az_location" {
  description = "The Azure region where the Redis cache will be created."
  type        = string
}

variable "az_rg_name" {
  description = "The name of the resource group in which the Redis cache will be created."
  type        = string
}

variable "redis_cache_sku_name" {
  description = "The SKU of the Redis cache."
  type        = string
  default     = "Standard"
}

variable "redis_cache_family" {
  description = "The family of the Redis cache."
  type        = string
  default     = "C"
}

variable "redis_cache_capacity" {
  description = "The capacity of the Redis cache."
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
