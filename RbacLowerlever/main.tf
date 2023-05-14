# Azure Resource Manager
provider "azurerm" {
  version = ">=2.0.0"
  features {}
  subscription_id = "4aa0a432-11bd-465b-8454-270ce1f20b11"
  tenant_id       = "59e26839-8e3a-40a6-8540-264cf6df1059"
}


data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

output "kvid" {
  value = "${data.azurerm_key_vault.keyvault.id}"
}

data "azurerm_key_vault_secret" "secretval" {
  name      = var.secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

//data "azurerm_key_vault_key" "keyval" {
//  name      = var.key_name
//  key_vault_id = data.azurerm_key_vault.keyvault.id
//}

//data "azurerm_key_vault_certificate" "certval" {
 // name      = var.cert_name
 // key_vault_id = data.azurerm_key_vault.keyvault.id

  # vault_uri is deprecated in latest azurerm, use key_vault_id instead.
  # vault_uri = "https://mykeyvault.vault.azure.net/"
//}

resource "azurerm_role_assignment" "role-secret-user" {
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "30b62b0e-04ee-459a-8b73-96061ef4f359"
  scope                = "${data.azurerm_key_vault.keyvault.id}/secrets/${data.azurerm_key_vault_secret.secretval.name}"
  //scope                = "${data.azurerm_key_vault.keyvault.id}/secrets/${data.azurerm_key_vault_secret.secretval.name}"
  // scope                = "/subscriptions/xxxxxxxxx/resourceGroups/kv_rbac_terraform_rg/providers
  //                         /Microsoft.KeyVault/vaults/demokv01093/secrets/MySecret"
  // scope                = azurerm_key_vault_secret.database-password.id
}

//resource "azurerm_role_assignment" "role-key-user" {
//  role_definition_name = "Key Vault Crypto User"
//  principal_id         = "30b62b0e-04ee-459a-8b73-96061ef4f359"
//  scope                = "${data.azurerm_key_vault.keyvault.id}/keys/${data.azurerm_key_vault_key.keyval.name}"
//}

//resource "azurerm_role_assignment" "role-cert-user" {
//  role_definition_name = "Key Vault Secrets User"
//  principal_id         = "30b62b0e-04ee-459a-8b73-96061ef4f359"
//  scope                = "${data.azurerm_key_vault.keyvault.id}/certificates/${data.azurerm_key_vault_certificate.certval.name}"
//}
