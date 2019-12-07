terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = "~>1.21"
}

########################################################################################################
# Generate a random password for VM Admin user 
########################################################################################################

resource "random_password" "vmadminpassword" {
  length = 16
  special = true
  override_special = "_%@"
}

########################################################################################################
# Identify the subnet in which the NIC card has to be created
########################################################################################################
data "azurerm_subnet" "subnet" {
  name                  = "${var.subnet}"
  virtual_network_name  = "NNANPSpoke-NNBE-Eng"
  resource_group_name   = "AzureVnet"
}

########################################################################################################
# Create Resource Group
########################################################################################################
resource azurerm_resource_group "nnbe" {
  name      = "${var.name}rg"
  location  = "${var.location}"

  tags ={
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
}


resource "azurerm_management_lock" "lockresourcegroup" {
  name       = "lockresourcegroup"
  scope      = "${azurerm_resource_group.nnbe.id}"
  lock_level = "CanNotDelete"
  notes      = "Resources in this resource group cannot be deleted"
}

########################################################################################################
# Create Network Interface Card
########################################################################################################
resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  location            = "${azurerm_resource_group.nnbe.location}"
  resource_group_name = "${azurerm_resource_group.nnbe.name}"

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
# Create Virtual Machine
########################################################################################################
resource "azurerm_virtual_machine" "vm" {
    name                    = "${var.name}-vm"
    location                = "${azurerm_resource_group.nnbe.location}"
    resource_group_name     = "${azurerm_resource_group.nnbe.name}"
    network_interface_ids   = ["${azurerm_network_interface.nic.id}"]
    vm_size                 = "Standard_B4ms"
    
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
      admin_username = "${var.admin_username}"
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