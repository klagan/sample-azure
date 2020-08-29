output "keyvault_id" {
  value = azurerm_key_vault.my_vault.id
}

output "keyvault_vault_uri" {
  value = azurerm_key_vault.my_vault.vault_uri
}