terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = "~>1.21"
}


########################################################################################################
# Create Custom Roles in Azure
#######################################################################################################

module "customroles" {
  source          = "../../terraform_iac_modules/azure_custom_roles"
}


