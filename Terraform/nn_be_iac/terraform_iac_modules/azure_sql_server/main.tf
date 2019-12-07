########################################################################################################
# Identify the Log Analytics Workspace
########################################################################################################
data "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "${var.logworkspace}"
  resource_group_name = "${var.rgmonitor}"
}

########################################################################################################
# Identify the storage account for storing monitoring logs
########################################################################################################
data "azurerm_storage_account" "storagemonitor" {
  name                = "${var.storagemonitor}"
  resource_group_name = "${var.rgmonitor}"
}

########################################################################################################
# Generate a random password for SQL Admin user 
########################################################################################################

resource "random_password" "sqladminpassword" {
  length = 16
  special = true
  override_special = "_%@"
}

########################################################################################################
# Identify the subnet in which the storage account has to be deployed
########################################################################################################
data "azurerm_subnet" "subnet" {
  name                  = "nnbewesteuaccsub"
  virtual_network_name  = "NNANPSpoke-NNBE"
  resource_group_name   = "AzureVnet"
}

########################################################################################################
# data source to access the configuration of the AzureRM provider.
########################################################################################################

data "azurerm_client_config" "current" {}


########################################################################################################
# Create Azure SQL Server
########################################################################################################
resource "azurerm_sql_server" "sqlserver" {
  name                         = "${var.name}sqlserver"
  resource_group_name          = "${var.name}rg"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "${random_password.sqladminpassword.result}"



      tags = {
          environment     = "${var.environment}"
          costcenter      = "${var.costcenter}"
          ApplicationName = "${var.ApplicationName}"
  }
}
 
#######################################################################################################
# Add Administrator to SQL Database
#######################################################################################################

resource "azurerm_sql_active_directory_administrator" "adadmin" {
  server_name                           =   "${azurerm_sql_server.sqlserver.name}"
  resource_group_name                   = "${var.name}rg"
  login                                 =  "GSAPAC-BE-DIL_Azure_Administration"
  tenant_id                             = "${data.azurerm_client_config.current.tenant_id}"
  object_id                             = "${data.azurerm_client_config.current.service_principal_object_id}"
}

########################################################################################################
# Attach the SQL Server to the existing Subnet within VNET
########################################################################################################
resource "azurerm_sql_virtual_network_rule" "sqlsrvrvnetrule" {
  name                = "sqlsrvrvnetrule"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  subnet_id           = "${data.azurerm_subnet.subnet.id}"
}

########################################################################################################
# Add SQL Database
########################################################################################################
resource "azurerm_sql_database" "sqldb" {
  name                                  =   "${var.name}sqldb"
  resource_group_name                   =   "${var.name}rg"
  location                              =   "${var.location}"
  server_name                           =   "${azurerm_sql_server.sqlserver.name}"
  create_mode                           =   "Default"
  edition                               =   "Standard"
  requested_service_objective_name      =   "S6"

    threat_detection_policy {
      state                       = "Enabled"
      storage_account_access_key  = "${data.azurerm_storage_account.storagemonitor.primary_access_key}"
      storage_endpoint            = "${data.azurerm_storage_account.storagemonitor.primary_blob_endpoint}"
      email_account_admins        = "Disabled"
      retention_days              = "10"
      email_addresses             = ["mayank.srivastava@nn.be"]
  }
      tags = {
          environment     = "${var.environment}"
          costcenter      = "${var.costcenter}"
          ApplicationName = "${var.ApplicationName}"
  }
}

########################################################################################################
# Enable Diagnostic Settings for the SQL Database
########################################################################################################

resource "azurerm_monitor_diagnostic_setting" "sqldblog" {
  name                          = "${var.name}-monitor-sqldb"
  target_resource_id            = "${azurerm_sql_database.sqldb.id}"
  log_analytics_workspace_id    = "${data.azurerm_log_analytics_workspace.loganalytics.id}"

  log {
    category = "Audit"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "SQLInsights"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "AutomaticTuning"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "QueryStoreRuntimeStatistics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "QueryStoreWaitStatistics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "Errors"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "DatabaseWaitStatistics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "Timeouts"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "Blocks"
    enabled  = true

    retention_policy {
      enabled = false
    }
  } 
  log {
    category = "Deadlocks"
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
# Add Rules to the SQL Server
########################################################################################################

resource "azurerm_sql_firewall_rule" "rule1" {
  name                = "${var.rule_1_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_1_start_ip}"
  end_ip_address      = "${var.rule_1_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule2" {
  name                = "${var.rule_2_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_2_start_ip}"
  end_ip_address      = "${var.rule_2_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule3" {
  name                = "${var.rule_3_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_3_start_ip}"
  end_ip_address      = "${var.rule_3_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule4" {
  name                = "${var.rule_4_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_4_start_ip}"
  end_ip_address      = "${var.rule_4_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule5" {
  name                = "${var.rule_5_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_5_start_ip}"
  end_ip_address      = "${var.rule_5_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule6" {
  name                = "${var.rule_6_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_6_start_ip}"
  end_ip_address      = "${var.rule_6_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule7" {
  name                = "${var.rule_7_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_7_start_ip}"
  end_ip_address      = "${var.rule_7_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule8" {
  name                = "${var.rule_8_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_8_start_ip}"
  end_ip_address      = "${var.rule_8_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule9" {
  name                = "${var.rule_9_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_9_start_ip}"
  end_ip_address      = "${var.rule_9_end_ip}"
}

resource "azurerm_sql_firewall_rule" "rule10" {
  name                = "${var.rule_10_name}"
  resource_group_name = "${var.name}rg"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.rule_10_start_ip}"
  end_ip_address      = "${var.rule_10_end_ip}"
}