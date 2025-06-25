resource "azurerm_stream_analytics_job" "job" {
  name                = "rtstockjob"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  streaming_units     = 1
  sku                 = "Standard"
  compatibility_level = "1.2"
  data_locale         = "en-US"
}

resource "azurerm_stream_analytics_stream_input_eventhub" "input" {
  name                          = "rtstockeventhubinput"
  stream_analytics_job_name     = azurerm_stream_analytics_job.job.name
  resource_group_name           = azurerm_resource_group.rg.name
  servicebus_namespace          = azurerm_eventhub_namespace.namespace.name
  eventhub_name                 = azurerm_eventhub.hub.name
  shared_access_policy_key      = azurerm_eventhub_namespace_authorization_rule.auth_rule.primary_key
  shared_access_policy_name     = azurerm_eventhub_namespace_authorization_rule.auth_rule.name
  consumer_group_name           = "$Default"
}

resource "azurerm_eventhub_namespace_authorization_rule" "auth_rule" {
  name                = "StreamAnalyticsPolicy"
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  resource_group_name = azurerm_resource_group.rg.name
  listen              = true
  send                = true
  manage              = true
}

resource "azurerm_stream_analytics_output_blob" "output" {
  name                          = "rtstockoutput"
  stream_analytics_job_name     = azurerm_stream_analytics_job.job.name
  resource_group_name           = azurerm_resource_group.rg.name
  storage_account_name          = azurerm_storage_account.adls.name
  storage_account_key           = azurerm_storage_account.adls.primary_access_key
  container_name                = "output"
  date_format                   = "yyyy/MM/dd"
  time_format                   = "HH"
  path_pattern                  = "{date}/{time}"
  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}
