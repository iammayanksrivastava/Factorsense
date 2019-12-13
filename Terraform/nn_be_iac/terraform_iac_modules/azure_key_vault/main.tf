########################################################################################################
# Identify the Log Analytics Workspace
########################################################################################################
data "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "${var.logworkspace}"
  resource_group_name = "${var.rgmonitor}"
}

########################################################################################################
# Identify the subnet in which the Key Vault has to be deployed
########################################################################################################
data "azurerm_subnet" "subnet" {
  name                  = "nnbewesteuaccsub"
  virtual_network_name  = "NNANPSpoke-NNBE"
  resource_group_name   = "AzureVnet"
}

########################################################################################################
# Check if the resource group has been created                                                         #
########################################################################################################

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.name}keyvault"
  location                    = "${var.location}"
  resource_group_name         = "${var.name}rg"
  enabled_for_disk_encryption =  true
  tenant_id                   = "${var.tenant_id}"
  sku_name                    = "${var.sku_name}"

  # access_policy {
  #   tenant_id = "${var.tenant_id}"
  #   object_id = "d746815a-0433-4a21-b95d-fc437d2d475b"

  #   key_permissions = [
  #     "get","list"
  #   ]

  #   secret_permissions = [
  #     "get","list"
  #   ]

  #   storage_permissions = [
  #     "get","list"
  #   ]
  # }
  
  network_acls {
    default_action              = "Deny"
    bypass                      = "AzureServices"
    virtual_network_subnet_ids  = ["${data.azurerm_subnet.subnet.id}"]
  }


    tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
}


#######################################################################################################
# Enable Diagnostic Settings of KeyVault
#######################################################################################################

resource "azurerm_monitor_diagnostic_setting" "monitorkeyvault" {
  name                        =  "${var.name}-monitor-keyvault"
  target_resource_id          = "${azurerm_key_vault.keyvault.id}"
  log_analytics_workspace_id  = "${data.azurerm_log_analytics_workspace.loganalytics.id}"

  log {
    category = "AuditEvent"
    enabled  = true

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

########################################################################################################
# Enable Do Not Delete Resource Lock
########################################################################################################

resource "azurerm_management_lock" "dndkv" {
  name       = "dndkv"
  scope      = "${azurerm_key_vault.keyvault.id}"
  lock_level = "CanNotDelete"
  notes      = "Do Not Delete this resource"
}