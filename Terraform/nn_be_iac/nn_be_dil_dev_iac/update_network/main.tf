
terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = "~>1.21"
}


########################################################################################################
# Update Diagnostic Settings for the Network Security Group 
########################################################################################################
module updatensgdiaglog {
  source                           =  "../../terraform_iac_modules/azure_nsg"
  name                             =  "${var.name}"
  nsgname                          =  "${var.nsgname}"
  nsgresourcegroup                 =  "${var.nsgresourcegroup}"
}


########################################################################################################
# Update Diagnostic Settings for the Virtual Network
########################################################################################################
module updatevnetdiaglog {
  source                           =  "../../terraform_iac_modules/azure_vnet"
  name                             =  "${var.name}"
}