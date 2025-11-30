output "function_app_name" {
  description = "The name of the Function App"
  value       = module.function_app.function_app_name
}

output "function_app_url" {
  description = "The URL of the Function App"
  value       = module.function_app.function_app_url
}

output "function_app_default_hostname" {
  description = "The default hostname of the Function App"
  value       = module.function_app.function_app_default_hostname
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = module.key_vault.key_vault_name
}
