output "service_plan_id" {
  description = "The ID of the App Service Plan."
  value       = azurerm_service_plan.wap_sp_website.id
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan."
  value       = var.wap_sp_name
}
