# Azure Resource Manager
provider "azurerm" {
  version = ">=2.0.0"
  features {}
  subscription_id = "4aa0a432-11bd-465b-8454-270ce1f20b11"
  tenant_id       = "59e26839-8e3a-40a6-8540-264cf6df1059"
}

# Azure AD
provider "azuread" {
  version = ">=0.7.0"
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

output "kvid" {
  value = "${data.azurerm_key_vault.keyvault.id}"
}

resource "azurerm_role_assignment" "role-secret-officer" {
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = "30b62b0e-04ee-459a-8b73-96061ef4f359"
  scope                = "${data.azurerm_key_vault.keyvault.id}"
  //scope                = "${data.azurerm_key_vault.keyvault.id}/secrets/${data.azurerm_key_vault_secret.secretval.name}"
  // scope                = "/subscriptions/xxxxxxxxx/resourceGroups/kv_rbac_terraform_rg/providers
}

resource "azurerm_role_assignment" "role-Certificates-officer" {
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = "30b62b0e-04ee-459a-8b73-96061ef4f359"
  scope                = "${data.azurerm_key_vault.keyvault.id}"
  // scope                = "/subscriptions/xxxxxxxxx/resourceGroups/kv_rbac_terraform_rg/providers
  //                         /Microsoft.KeyVault/vaults/demokv01093/secrets/MySecret"
}

resource "azurerm_role_assignment" "role-key-officer" {
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = "30b62b0e-04ee-459a-8b73-96061ef4f359"
  scope                = "${data.azurerm_key_vault.keyvault.id}"
  // scope                = "/subscriptions/xxxxxxxxx/resourceGroups/kv_rbac_terraform_rg/providers
  //                         /Microsoft.KeyVault/vaults/demokv01093/secrets/MySecret"
  // scope                = azurerm_key_vault_secret.database-password.id
}
