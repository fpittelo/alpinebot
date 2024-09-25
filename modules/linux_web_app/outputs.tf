output "app_service_id" {
  value = azurerm_linux_web_app.wap_app.id
}

output "service_plan_id" {
  value = var.wap_sp_name
}
