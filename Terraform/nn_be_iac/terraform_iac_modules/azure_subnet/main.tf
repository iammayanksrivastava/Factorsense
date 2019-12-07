########################################################################################################
# Details of the VNet provided by the CS&H team.
########################################################################################################
data "azurerm_resource_group" "AzureVnet" {
  name = "AzureVnet"
  }

data "azurerm_virtual_network" "NNANPSpoke-NNBE-Eng" {
  name                = "NNANPSpoke-NNBE-Eng"
  resource_group_name = "AzureVnet"
  }

## Output the details of the Vnet in the AzureVnet Resource group
output "NNANPSpoke-NNBE-Eng" {
  value = "${data.azurerm_virtual_network.NNANPSpoke-NNBE-Eng.id}"
}

########################################################################################################
# Details of the NSG and Route Table
########################################################################################################

data "azurerm_resource_group" "AcesNetworkRg" {
  name = "AcesNetworkRg"
}

data "azurerm_network_security_group" "ACES-Cloud-Perimeter-Shell" {
    name                = "ACES-Cloud-Perimeter-Shell"
    resource_group_name = "AcesNetworkRg"
    }

output "ACES-Cloud-Perimeter-Shell" {
  value = "${data.azurerm_network_security_group.ACES-Cloud-Perimeter-Shell.id}"
}


data "azurerm_route_table" "ACES-Internet-UDR" {
  name                = "ACES-Internet-UDR"
  resource_group_name = "AcesNetworkRg"
}

output "ACES-Internet-UDR" {
  value = "${data.azurerm_route_table.ACES-Internet-UDR.id}"
}

########################################################################################################
# Create Subnet in the CS&H Vnet Resource Group
########################################################################################################

resource "azurerm_subnet" "subnet" {
        name                        = "${var.name}subnet"
        resource_group_name         = "${data.azurerm_resource_group.AzureVnet.name}"
        virtual_network_name        = "${data.azurerm_virtual_network.NNANPSpoke-NNBE-Eng.name}"
        address_prefix              = "${var.subnet}"
        network_security_group_id   = "${data.azurerm_network_security_group.ACES-Cloud-Perimeter-Shell.id}"
        route_table_id              = "${data.azurerm_route_table.ACES-Internet-UDR.id}"
        service_endpoints           = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"]
}


