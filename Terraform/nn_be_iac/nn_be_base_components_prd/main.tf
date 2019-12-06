terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = "~>1.21"
}


########################################################################################################
# Create Log Analytics Workspace
#######################################################################################################

module "azure_log_monitor" {
  source                    = "../terraform_iac_modules/azure_log_monitor"
  name                      = "${var.name}"
  location                  = "${var.location}"
  environment               = "${var.environment}"
  costcenter                = "${var.costcenter}"
  application               = "${var.application}"
  account_tier              = "${var.account_tier}"
  replication_type          = "${var.replication_type}"
  accountkind               = "${var.accountkind}"
}

