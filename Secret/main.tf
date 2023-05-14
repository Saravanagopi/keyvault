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

resource "azurerm_key_vault_secret" "db-pwd" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
  tags      = {
      "tag1": "tag_value_1"
      "tag2": "tag_value_2"
 }
}

output "kvid" {
  value = "${data.azurerm_key_vault.keyvault.id}"
}
