Azure Key Vault Module 🔐✨
Welcome to the Key Vault Wizardry module! Protect your secrets with more magic than a unicorn guarding a rainbow. 🦄🌈

This Terraform module conjures up an Azure Key Vault to securely store your secrets, keys, and certificates. Keep your secrets safe from prying eyes and nosy dragons. 🐉

Features 🪄
Secure Storage: Safeguard your cryptographic keys and secrets.
Disk Encryption: Optionally enable disk encryption to add an extra layer of security.
Purge Protection: Prevent accidental or malicious deletion of your Key Vault.
RBAC Authorization: Leverage Azure RBAC for access control.
Customizable Tags: Apply custom tags to organize your resources.
Usage 📝
hcl
Copy code
module "key_vault" {
  source = "../modules/key_vault"

  az_rg_name                   = var.az_rg_name
  az_kv_name                   = var.az_kv_name
  location                     = var.location
  tenant_id                    = var.tenant_id
  enabled_for_disk_encryption  = true
  purge_protection_enabled     = true
  enable_rbac_authorization    = true
  tags                         = var.tags
}
Input Variables 📥
Variable	Description	Type	Default	Required
az_rg_name	Resource Group Name for the Key Vault	string	n/a	yes
az_kv_name	Name of the Key Vault	string	n/a	yes
location	Azure region for the Key Vault	string	n/a	yes
tenant_id	Tenant ID for Azure	string	n/a	yes
enabled_for_disk_encryption	Enable disk encryption (true or false)	bool	false	no
purge_protection_enabled	Enable purge protection (true or false)	bool	true	no
enable_rbac_authorization	Enable RBAC authorization (true or false)	bool	true	no
tags	Map of tags to apply to the Key Vault	map(string)	{}	no
Output Variables 📤
Output	Description
key_vault_id	The ID of the Key Vault
key_vault_name	The name of the Key Vault
key_vault_uri	The URI of the Key Vault
Example 🔍
Check out the examples directory to see how to make your secrets disappear (into secure storage, that is)!

Notes 📝
No Rabbits Here: While we can't pull a rabbit out of a hat, we can securely store your secrets.
Stay Secure: Always handle your secrets with care and follow best security practices.
Contributing 🤝
Found a spell that could enhance this module? Feel free to open an issue or a pull request!

License 📄
This project is licensed under the MIT License - see the LICENSE file for details.