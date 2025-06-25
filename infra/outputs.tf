output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.namespace.name
}

output "eventhub_name" {
  value = azurerm_eventhub.hub.name
}

output "storage_account_name" {
  value = azurerm_storage_account.adls.name
}
