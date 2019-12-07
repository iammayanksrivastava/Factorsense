
########################################################################################################
# Identify the Network Security Group to enable Diagnostic Settings
########################################################################################################

data "azurerm_network_security_group" "nsg" {
  name                = "${var.nsgname}"
  resource_group_name = "${var.nsgresourcegroup}"
}


data "azurerm_log_analytics_workspace" "log" {
  name                = "${var.name}loganalytics"
  resource_group_name = "${var.name}rg-monitor"
}


########################################################################################################
# Enable Diagnostic Settings for the Network Security Group
########################################################################################################
resource "azurerm_monitor_diagnostic_setting" "nsg" {
  name               = "nnbe-enable-nsg-diagnostic"
  target_resource_id = "${data.azurerm_network_security_group.nsg.id}"
  log_analytics_workspace_id = "${data.azurerm_log_analytics_workspace.log.id}"

  log {
    category = "NetworkSecurityGroupEvent"
    enabled  = true
        
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "NetworkSecurityGroupRuleCounter"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}
