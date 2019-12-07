########################################################################################################
# Identify the Log Analytics Workspace
########################################################################################################
data "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "${var.logworkspace}"
  resource_group_name = "${var.rgmonitor}"
}
########################################################################################################
# Create Data Factory                                                                                  #
########################################################################################################

resource "azurerm_data_factory" "adf" {
  name                = "${var.name}datafactory"
  location            = "${var.location}"
  resource_group_name = "${var.name}rg"
  
  identity{
    type= "SystemAssigned"
  }

  # vsts_configuration{
  #   account_name        = "${var.account_name}"
  #   branch_name         = "${var.branch_name}"
  #   project_name        = "${var.project_name}"
  #   repository_name     = "${var.repository_name}"
  #   root_folder         = "${var.root_folder}"
  #   tenant_id           = "${var.tenant_id}"
  # }
  
    tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
}


########################################################################################################
# Assign Contributor role to Azure Data Factory 
########################################################################################################
resource "azurerm_role_assignment" "ADFContributor" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.name}rg"
  role_definition_name = "Data Factory Contributor"
  principal_id         = "${var.azure_data_factory_contributor_principal_id}"
}


########################################################################################################
# Assign Contributor role to Azure Data Factory for API Calls
########################################################################################################
resource "azurerm_role_assignment" "ADFContributorAPI" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.name}rg/providers/Microsoft.DataFactory/factories/nnbetstdildatafactory"
  role_definition_name = "Data Factory Contributor"
  principal_id         = "b4a91528-c2eb-4439-a42b-1b5433ceb9cd"
}


# ########################################################################################################################################
# # Assign Storage Account Contributor role to Azure Data Factory on Blob 
# ########################################################################################################################################
# resource "azurerm_role_assignment" "ADLSStorageAccountContributor" {
#   scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.name}rg/providers/Microsoft.Storage/storageAccounts/${var.name}storageaccount"
#   role_definition_name = "Storage Account Contributor"
#   principal_id         = "${lookup(azurerm_data_factory.adf.identity[0],"principal_id")}"
# }


########################################################################################################################################
# Assign Storage Account Contributor role to Azure Data Factory on ADLS
########################################################################################################################################
resource "azurerm_role_assignment" "StorageAccountContributor" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.name}rg/providers/Microsoft.Storage/storageAccounts/${var.name}adls"
  role_definition_name = "Storage Account Contributor"
  principal_id         = "${lookup(azurerm_data_factory.adf.identity[0],"principal_id")}"
}

########################################################################################################################################
# Assign Storage Blob Data Contributor role to Azure Data Factory on ADLS
########################################################################################################################################
resource "azurerm_role_assignment" "StorageBlobDataContributor" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.name}rg/providers/Microsoft.Storage/storageAccounts/${var.name}adls"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = "${lookup(azurerm_data_factory.adf.identity[0],"principal_id")}"
}

########################################################################################################################################
# Assign Storage Blob Data Owner role to Azure Data Factory on ADLS
########################################################################################################################################
resource "azurerm_role_assignment" "StorageBlobDataOwner" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.name}rg/providers/Microsoft.Storage/storageAccounts/${var.name}adls"
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = "${lookup(azurerm_data_factory.adf.identity[0],"principal_id")}"
}


########################################################################################################
# Enable Diagnostic Settings for Azure Data Factory
########################################################################################################

resource "azurerm_monitor_diagnostic_setting" "monitor-tst-adf" {
  name                        = "${var.name}-monitory-datafactory"
  target_resource_id          = "${azurerm_data_factory.adf.id}"
  log_analytics_workspace_id  = "${data.azurerm_log_analytics_workspace.loganalytics.id}"

  log {
    category = "PipelineRuns"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "TriggerRuns"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

    log {
    category = "ActivityRuns"
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

resource "azurerm_management_lock" "dndadf" {
  name       = "dndadf"
  scope      = "${azurerm_data_factory.adf.id}"
  lock_level = "CanNotDelete"
  notes      = "Do Not Delete this resource"
}