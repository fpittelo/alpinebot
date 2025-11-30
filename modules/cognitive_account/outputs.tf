output "openai_account_id" {
  value = azurerm_cognitive_account.alpinebot_openai.id
}

output "openai_key" {
  value     = azurerm_cognitive_account.alpinebot_openai.primary_access_key
  sensitive = true
}

output "cognitive_account_endpoint" {
  value = azurerm_cognitive_account.alpinebot_openai.endpoint
}

output "openai_account_name" {
  value = azurerm_cognitive_account.alpinebot_openai.name
}
