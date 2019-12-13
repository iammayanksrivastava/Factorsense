########################################################################################################
# Identify the Virtual Network
########################################################################################################
data "azurerm_virtual_network" "vnet" {
  name                = "NNANPSpoke-NNBE-Eng"
  resource_group_name = "AzureVnet"
}

########################################################################################################
# Identify the Log Analytics Workspace
########################################################################################################
data "azurerm_log_analytics_workspace" "log" {
  name                = "${var.name}loganalytics"
  resource_group_name = "${var.name}rg-monitor"
}

########################################################################################################
# Enable Diagnostic Settings for the Virtual Network 
########################################################################################################
resource "azurerm_monitor_diagnostic_setting" "vnet" {
  name                          = "nnbe-vnet-diagnostics"
  target_resource_id            = "${data.azurerm_virtual_network.vnet.id}"
  log_analytics_workspace_id    = "${data.azurerm_log_analytics_workspace.log.id}"

  log {
    category = "VMProtectionAlerts"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}