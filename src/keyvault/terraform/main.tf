resource azurerm_resource_group my_environment_resource_group {
  name     = local.resource_group_name
  location = var.location
  tags     = merge(local.tags)
}

resource "azurerm_key_vault" "my_vault" {
  name                        = local.keyvault_name
  location                    = azurerm_resource_group.my_environment_resource_group.location
  resource_group_name         = azurerm_resource_group.my_environment_resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.keyvault_sku_name
  tags                        = local.tags
}

resource "azurerm_key_vault_access_policy" "tester_policy" {
  key_vault_id            = azurerm_key_vault.my_vault.id
  tenant_id               = local.tester_tenant_id
  object_id               = local.tester_object_id
  key_permissions         = var.tester_key_permissions
  secret_permissions      = var.tester_secret_permissions
  certificate_permissions = var.tester_certificate_permissions
  depends_on              = [azurerm_key_vault.my_vault]
}

resource "azurerm_key_vault_secret" "testsection_name" {
  name         = "TestSection--name"
  value        = "name from keyvault"
  key_vault_id = azurerm_key_vault.my_vault.id
  depends_on   = [azurerm_key_vault.my_vault, azurerm_key_vault_access_policy.tester_policy]
}

resource "azurerm_key_vault_secret" "testsection_value" {
  name         = "TestSection--value"
  value        = "value from keyvault"
  key_vault_id = azurerm_key_vault.my_vault.id
  depends_on   = [azurerm_key_vault.my_vault, azurerm_key_vault_access_policy.tester_policy]
}

resource "azurerm_key_vault_secret" "sqlserver-connectionstring" {
  name         = "sqlserver-connectionstring"
  value        = "sqlserver-connectionstring from keyvault"
  key_vault_id = azurerm_key_vault.my_vault.id
  depends_on   = [azurerm_key_vault.my_vault, azurerm_key_vault_access_policy.tester_policy]
}