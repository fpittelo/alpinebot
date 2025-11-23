# Azure Function App Module

This Terraform module creates an Azure Function App with Linux hosting and Python runtime.

## Resources Created

- Azure Storage Account (for Function App internal storage)
- Azure Linux Function App (Python 3.12)

## Features

- Python 3.12 runtime
- Configurable CORS origins with validation
- Application Insights integration
- Custom app settings support
- Uses existing App Service Plan

## Security Notes

- CORS validation prevents wildcard `*` origins
- Explicit origins must be specified (no default wildcard)
- Note: Advanced wildcard patterns (e.g., `http://*`) are not validated; use explicit URLs for maximum security

## Usage

```hcl
module "function_app" {
  source = "../modules/function_app"

  function_app_name              = "my-function-app"
  storage_account_name           = "myfuncsa"
  az_location                    = "SwitzerlandNorth"
  az_rg_name                     = "my-resource-group"
  service_plan_id                = module.app_service_plan.service_plan_id
  app_insights_connection_string = azurerm_application_insights.insights.connection_string
  
  app_settings = {
    "AZURE_OPENAI_API_KEY"       = var.openai_api_key
    "AZURE_OPENAI_ENDPOINT"      = var.openai_endpoint
  }

  cors_allowed_origins = ["https://myapp.azurewebsites.net"]
  
  tags = {
    environment = "dev"
    project     = "AlpineBot"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| function_app_name | Name of the Azure Function App | string | n/a | yes |
| storage_account_name | Name of the storage account for the Function App | string | n/a | yes |
| az_location | Azure region for the Function App | string | n/a | yes |
| az_rg_name | Resource group name | string | n/a | yes |
| service_plan_id | ID of the App Service Plan for the Function App | string | n/a | yes |
| app_settings | Application settings for the Function App | map(string) | {} | no |
| cors_allowed_origins | List of allowed CORS origins (must be explicitly configured, no default) | list(string) | [] | yes |
| app_insights_connection_string | Application Insights connection string | string | n/a | yes |
| tags | Tags to apply to Function App resources | map(string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| function_app_id | The ID of the Function App |
| function_app_name | The name of the Function App |
| function_app_default_hostname | The default hostname of the Function App |
| function_app_url | The URL of the Function App |
