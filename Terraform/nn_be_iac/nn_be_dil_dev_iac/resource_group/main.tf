terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = "~>1.21"
}


########################################################################################################
# Create Resource Group for Development
#######################################################################################################

module "resourcegroup" {
  source          = "../../terraform_iac_modules/azure_resource_group"
  name            = "${var.name}"
  location        = "${var.location}"
  environment     = "${var.environment}"
  costcenter      = "${var.costcenter}"
  application     = "${var.ApplicationName}"
}
