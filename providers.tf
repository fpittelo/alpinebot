provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
 }
}

provider "azuread" {
  # tenant_id will be passed from main.tf or variables.tf
  client_id = var.az_client_id
  tenant_id = var.az_tenant_id
  use_oidc = true
}