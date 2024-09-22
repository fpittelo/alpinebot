output "app_service_id" {
  value = azurerm_linux_web_app.wap_app.id
}

output "service_plan_id" {
  value = azurerm_service_plan.wap_sp_website.id
}
