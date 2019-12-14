########################################################################################################
# Check if resource group has been created. 
########################################################################################################

# resource "null_resource" "nnberesourcegroup" {
#   triggers = {
#     resource_group_name  = "${var.name}rg"
#   }
# }

########################################################################################################
# Identify the resource group
########################################################################################################

data "azurerm_resource_group" "backbonerg" {
  name = "${var.name}rg"
}
########################################################################################################
# Identify the subnet in which the storage account has to be deployed
########################################################################################################
# data "azurerm_subnet" "subnet" {
#   name                  = "nnbewesteuaccsub"
#   virtual_network_name  = "NNANPSpoke-NNBE"
#   resource_group_name   = "AzureVnet"
# }
# ########################################################################################################
# # Create Storage Account
# ########################################################################################################
resource "azurerm_storage_account" "storage" {
  # depends_on                = ["null_resource.nnberesourcegroup"]
  name                      = "${var.name}storageaccount"
  resource_group_name       = "${var.name}rg"
  location                  = "${var.location}"
  account_tier              = "${var.account_tier}"
  account_replication_type  = "${var.replication_type}"
  account_kind              = "${var.accountkind}"

  #  network_rules {
  #   default_action             = "Deny"
  #   virtual_network_subnet_ids = ["${data.azurerm_subnet.subnet.id}"]
  # }


  tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
}


########################################################################################################
# Create Container in the Storage Account
########################################################################################################

resource "azurerm_storage_container" "container" {
  name                  = "vhds"
  resource_group_name   = "${data.azurerm_resource_group.backbonerg.name}"
  storage_account_name  = "${azurerm_storage_account.storage.name}"
  container_access_type = "private"
}

########################################################################################################
# Create ADLS Storage Account 
########################################################################################################
# resource "azurerm_storage_account" "adls" {
#   name                      = "${var.name}adls"
#   resource_group_name       = "${var.name}rg"
#   location                  = "${var.location}"
#   account_tier              = "${var.account_tier}"
#   account_replication_type  = "${var.replication_type}"
#   account_kind              = "${var.accountkind}"
#   is_hns_enabled            =  true

#    network_rules {
#     default_action             = "Deny"
#     virtual_network_subnet_ids = ["${data.azurerm_subnet.subnet.id}"]
#   }


#   tags = {
#     environment     = "${var.environment}"
#     costcenter      = "${var.costcenter}"
#     ApplicationName = "${var.ApplicationName}"
#   }
# }


# ########################################################################################################
# # Assign GRRPAC-BE-AzureRES_DIL_DEV-StorageAccountContributor Contributor access to the Storage Account 
# ########################################################################################################
# resource "azurerm_role_assignment" "StorageAccountContributor" {
#   depends_on           =   ["azurerm_storage_account.adls"]
#   scope                =   "${azurerm_storage_account.adls.id}" #Changed from hard coded. 
#   role_definition_name = "Storage Account Contributor"
#   principal_id         = "${var.storage_account_contributor_principal_id}" #Change it to data block
# }


# ########################################################################################################
# # Assign GRRPAC-BE-AzureRES_DIL_DEV-StorageAccountContributor Contributor access to the ADLS
# ########################################################################################################
# resource "azurerm_role_assignment" "ADLSContributor" {
#     depends_on         =   ["azurerm_storage_account.storage"]
#   scope                = "/subscriptions/2ed57147-270f-48a9-8aca-9a760bea28ec/resourceGroups/${var.name}rg/providers/Microsoft.Storage/storageAccounts/${var.name}adls"
#   role_definition_name = "Storage Account Contributor"
#   principal_id         = "${var.storage_account_contributor_principal_id}"
# }


