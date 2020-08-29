locals {
  resource_group_name = format("%s-%s", var.client, var.environment)
  keyvault_name       = format("%s-%s", var.client, var.environment)
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  tester_tenant_id    = data.azurerm_client_config.current.tenant_id
  tester_object_id    = data.azuread_group.developers.object_id
  tags = {
    author      = "kaml"
    environment = var.environment
    tool        = "terraform"
  }
}

data "azurerm_client_config" "current" {}

data "azuread_group" "developers" {
  name = "Testers"
}

variable "tester_key_permissions" {
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "tester_secret_permissions" {
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "tester_certificate_permissions" {
  default = ["backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "restore", "setissuers", "update"]
}

variable location {}

variable keyvault_sku_name {}

variable environment {}

variable client {}
