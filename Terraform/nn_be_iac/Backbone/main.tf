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



########################################################################################################
# Create Subnet in the AzureVnet Resource group
#######################################################################################################

# module "azure_subnet" {
#   source          = "../../terraform_iac_modules/azure_subnet"
#   subnet          = "${var.subnet}"
#   name            = "${var.name}"

# }


########################################################################################################
# Create Azure Key Vault
########################################################################################################

module "keyvault" {
  source                            = "../../terraform_iac_modules/azure_key_vault"
  name                              = "${var.name}"
  location                          = "${var.location}"
  environment                       = "${var.environment}"
  costcenter                        = "${var.costcenter}"
  ApplicationName                   = "${var.ApplicationName}"
  tenant_id                         = "${var.tenant_id}"
  sku_name                          = "${var.sku_name}"
  rgmonitor                         = "${var.rgmonitor}"
  logworkspace                      = "${var.logworkspace}"
  storagemonitor                    = "${var.storagemonitor}"
  }

########################################################################################################
# Create Storage Account
#######################################################################################################

# module "storageaccount" {
#   source                                    = "../../terraform_iac_modules/azure_storage_account"
#   name                                      = "${var.name}"
#   location                                  = "${var.location}"
#   environment                               = "${var.environment}"
#   costcenter                                = "${var.costcenter}"
#   ApplicationName                           = "${var.ApplicationName}"
#   account_tier                              = "${var.account_tier}"
#   replication_type                          = "${var.replication_type}"
#   accountkind                               = "${var.accountkind}"
#   subscription_id                           = "${var.subscription_id}" 
#   storage_account_contributor_principal_id  = "${var.storage_account_contributor_principal_id}"
# }

# ########################################################################################################
# # Create Data Factory
# #######################################################################################################

# module "datafactory" {
#   source                                            = "../../terraform_iac_modules/azure_data_factory"
#   name                                              = "${var.name}"
#   location                                          = "${var.location}"
#   environment                                       = "${var.environment}"
#   costcenter                                        = "${var.costcenter}"
#   ApplicationName                                   = "${var.ApplicationName}"
#   account_name                                      = "${var.account_name}"
#   branch_name                                       = "${var.branch_name}"
#   project_name                                      = "${var.project_name}"
#   repository_name                                   = "${var.repository_name}"
#   root_folder                                       = "${var.root_folder}"
#   tenant_id                                         = "${var.tenant_id}"
#   subscription_id                                   = "${var.subscription_id}" 
#   azure_data_factory_contributor_principal_id       = "${var.azure_data_factory_contributor_principal_id}"
#   rgmonitor                                         = "${var.rgmonitor}"
#   logworkspace                                      = "${var.logworkspace}"
#   storagemonitor                                    = "${var.storagemonitor}"
# }


# ########################################################################################################
# # Create SQL Server and SQL Database
# #######################################################################################################
# module "sqlserver" {
#   source                            = "../../terraform_iac_modules/azure_sql_server"
#   name                              = "${var.name}"
#   location                          = "${var.location}"
#   environment                       = "${var.environment}"
#   costcenter                        = "${var.costcenter}"
#   ApplicationName                   = "${var.ApplicationName}"
#   sql_administrator                 = "${var.sql_administrator}"
#   rule_1_name                       = "${var.rule_1_name}"
#   rule_1_start_ip                   = "${var.rule_1_start_ip}"
#   rule_1_end_ip                     = "${var.rule_1_end_ip}"
#   rule_2_name                       = "${var.rule_2_name}"
#   rule_2_start_ip                   = "${var.rule_2_start_ip}"
#   rule_2_end_ip                     = "${var.rule_2_end_ip}"
#   rule_3_name                       = "${var.rule_3_name}"
#   rule_3_start_ip                   = "${var.rule_3_start_ip}"
#   rule_3_end_ip                     = "${var.rule_3_end_ip}"
#   rule_4_name                       = "${var.rule_4_name}"
#   rule_4_start_ip                   = "${var.rule_4_start_ip}"
#   rule_4_end_ip                     = "${var.rule_4_end_ip}"
#   rule_5_name                       = "${var.rule_5_name}"
#   rule_5_start_ip                   = "${var.rule_5_start_ip}"
#   rule_5_end_ip                     = "${var.rule_5_end_ip}"
#   rule_6_name                       = "${var.rule_6_name}"
#   rule_6_start_ip                   = "${var.rule_6_start_ip}"
#   rule_6_end_ip                     = "${var.rule_6_end_ip}"
#   rule_7_name                       = "${var.rule_7_name}"
#   rule_7_start_ip                   = "${var.rule_7_start_ip}"
#   rule_7_end_ip                     = "${var.rule_7_end_ip}"
#   rule_8_name                       = "${var.rule_8_name}"
#   rule_8_start_ip                   = "${var.rule_8_start_ip}"
#   rule_8_end_ip                     = "${var.rule_8_end_ip}"
#   rule_9_name                       = "${var.rule_9_name}"
#   rule_9_start_ip                   = "${var.rule_9_start_ip}"
#   rule_9_end_ip                     = "${var.rule_9_end_ip}"
#   rule_10_name                      = "${var.rule_10_name}"
#   rule_10_start_ip                  = "${var.rule_10_start_ip}"
#   rule_10_end_ip                    = "${var.rule_10_end_ip}"
#   account_tier                      = "${var.account_tier}"
#   replication_type                  = "${var.replication_type}"
#   accountkind                       = "${var.accountkind}"
#   rgmonitor                         = "${var.rgmonitor}"
#   logworkspace                      = "${var.logworkspace}"
#   storagemonitor                    = "${var.storagemonitor}"
# }

 
# ########################################################################################################
# # Create Virtual Machine for Azure Data Factory Integration Runtime 
# ########################################################################################################

# module adfirvm {
#   source                            = "../../terraform_iac_modules/azure_vm"
#   name                              = "${var.name}"
#   location                          = "${var.location}"
#   environment                       = "${var.environment}"
#   costcenter                        = "${var.costcenter}"
#   ApplicationName                   = "${var.ApplicationName}"
#   vm_size                           = "${var.vm_size}"
#   vm_admin                          = "${var.vm_admin}"
#   vm_image_version                  = "${var.vm_image_version}"
#   rgmonitor                         = "${var.rgmonitor}"
#   logworkspace                      = "${var.logworkspace}"
#   storagemonitor                    = "${var.storagemonitor}"
#  }

# ########################################################################################################
# # Create Automation Account
# ########################################################################################################

# module automationaccount {
#   source                            = "../../terraform_iac_modules/azure_automation_account"
#   name                              = "${var.name}"
#   location                          = "${var.location}"
#   environment                       = "${var.environment}"
#   costcenter                        = "${var.costcenter}"
#   ApplicationName                   = "${var.ApplicationName}"
#  }