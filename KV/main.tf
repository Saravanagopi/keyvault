resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  enable_rbac_authorization   =  true
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = {
    application = "Production"
    source      = "ID Vault"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "30b62b0e-04ee-459a-8b73-96061ef4f359"

    secret_permissions = [
      "Get",
      "Set"
    ]
  }
}

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
  depends_on = [azurerm_key_vault.keyvault]
}

