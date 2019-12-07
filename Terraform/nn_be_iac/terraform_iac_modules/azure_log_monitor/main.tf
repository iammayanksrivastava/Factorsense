terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = "~>1.21"
}
########################################################################################################
# Create Resource Group
########################################################################################################
resource azurerm_resource_group "nnbe" {
  name      = "${var.name}rg-monitor"
  location  = "${var.location}"

  tags ={
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.application}"
  }
}

########################################################################################################
# Deploy Log Analytics Workspace for Monitoring
########################################################################################################

resource "azurerm_log_analytics_workspace" "test" {
  name                = "${var.name}loganalytics"
  location            = "${azurerm_resource_group.nnbe.location}"
  resource_group_name = "${azurerm_resource_group.nnbe.name}"
  sku                 = "PerGB2018"
  retention_in_days   = 30
}


########################################################################################################
# Create Storage Account for storing monitoring logs
########################################################################################################
resource "azurerm_storage_account" "storagemonitor" {
  name                      = "${var.name}monitorstorage"
  resource_group_name       = "${azurerm_resource_group.nnbe.name}"
  location                  = "${azurerm_resource_group.nnbe.location}"
  account_tier              = "${var.account_tier}"
  account_replication_type  = "${var.replication_type}"
  account_kind              = "${var.accountkind}"


  tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.application}"
  }
}
