# providers.tf

terraform {
  backend "azurerm" {
    resource_group_name   = "dev-bkd-alpinebot"         # Replace with your resource group name
    storage_account_name  = "devbkdalpinebotsa"      # Replace with your storage account name
    container_name        = "dev-bkd-alpinebot-co"      # Replace with your container name
    key                   = "dev-bkd-alpinebot.tfstate" # Replace with your Terraform state file name
  }

  required_providers {
    azurerm   = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1.0"  # Use the appropriate version
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.5.0"
    }
  }
}

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
  tenant_id = var.az_tenant_id
}