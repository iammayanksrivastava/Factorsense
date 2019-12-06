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
  name      = "${var.name}rg"
  location  = "${var.location}"

  tags ={
    environment = "${var.environment}"
    costcenter  = "${var.costcenter}"
    ApplicationName = "${var.application}"
  }
}

########################################################################################################
# Create Resource Group level Locks 
# Change Number: TDIL 747 
########################################################################################################
resource "azurerm_management_lock" "lockresourcegroup" {
  name       = "lockresourcegroup"
  scope      = "${azurerm_resource_group.nnbe.id}"
  lock_level = "CanNotDelete"
  notes      = "Resources in this resource group cannot be deleted"
}


# ########################################################################################################
# # Create Resource Group for monitoring
# ########################################################################################################
# resource azurerm_resource_group "nnbemonitor" {
#   name      = "${var.name}rg-monitor"
#   location  = "${var.location}"

#   tags ={
#     environment = "${var.environment}"
#     costcenter  = "${var.costcenter}"
#     ApplicationName = "${var.application}"
#   }
# }

########################################################################################################
# Create Resource Group level Locks 
# Change Number: TDIL 747 
########################################################################################################
# resource "azurerm_management_lock" "resourcegrouplevelmonitor" {
#   name       = "lockresourcegroup"
#   scope      = "${azurerm_resource_group.nnbemonitor.id}"
#   lock_level = "CanNotDelete"
#   notes      = "Resources in this resource group cannot be deleted"
# }

########################################################################################################
# Create Resource Group - Databricks
########################################################################################################
resource azurerm_resource_group "nnbedatabricks" {
  name      = "${var.name}rg-databricks"
  location  = "${var.location}"

  tags ={
    environment = "${var.environment}"
    costcenter  = "${var.costcenter}"
    ApplicationName = "${var.application}"
  }
}


########################################################################################################
# Create Resource Group level Locks 
# Change Number: TDIL 747 
########################################################################################################
# resource "azurerm_management_lock" "resourcegroupleveldbricks" {
#   name       = "lockresourcegroup"
#   scope      = "${azurerm_resource_group.nnbedatabricks.id}"
#   lock_level = "CanNotDelete"
#   notes      = "Resources in this resource group cannot be deleted"
# }
