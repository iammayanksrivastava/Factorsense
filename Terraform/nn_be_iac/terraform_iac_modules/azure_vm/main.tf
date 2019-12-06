########################################################################################################
# Generate a random password for VM Admin user 
########################################################################################################

resource "random_password" "vmadminpassword" {
  length = 16
  special = true
  override_special = "_%@"
}


########################################################################################################
# Identify the Log Analytics Workspace
########################################################################################################
data "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "${var.logworkspace}"
  resource_group_name = "${var.rgmonitor}"
}



########################################################################################################
# Identify the subnet in which the NIC card has to be created
########################################################################################################
data "azurerm_subnet" "subnet" {
  name                  = "nnbewesteuaccsub"
  virtual_network_name  = "NNANPSpoke-NNBE"
  resource_group_name   = "AzureVnet"
}
########################################################################################################
# Create Network Interface Card
########################################################################################################
resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.name}rg"

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
}

########################################################################################################
# Enable Diagnostic Settings for NIC Card
########################################################################################################

resource "azurerm_monitor_diagnostic_setting" "monitor-tst-nic" {
  name                        = "${var.name}-monitory-nic"
  target_resource_id          = "${azurerm_network_interface.nic.id}"
  log_analytics_workspace_id  = "${data.azurerm_log_analytics_workspace.loganalytics.id}"

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

########################################################################################################
# Create Virtual Machine
########################################################################################################
resource "azurerm_virtual_machine" "vm" {
    # depends_on            = ["null_resource.nnberesourcegroup"]
    name                  = "${var.name}-vm"
    location              = "westeurope"
    resource_group_name   = "${var.name}rg"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "Standard_B4ms"
    
    delete_os_disk_on_termination = true
    
    storage_image_reference {
      id          = "${var.vm_image_version}"
    }

    storage_os_disk {
      name              = "${var.name}vm"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile {
      computer_name  = "${var.name}vm"
      admin_username = "${var.vm_admin}"
      admin_password = "${random_password.vmadminpassword.result}"
    }
    os_profile_windows_config {
      provision_vm_agent        = true
      enable_automatic_upgrades = true
      timezone                  = "W. Europe Standard Time"
    }
    # Principal ID (for scope assignment) can only be retrieved after the virtual machine has been created
    identity {
      type = "SystemAssigned"
    }

    tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
      
}