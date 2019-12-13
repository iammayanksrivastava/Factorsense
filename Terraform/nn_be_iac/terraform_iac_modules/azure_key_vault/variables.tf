variable "location" {
  description = "The location/region where the resource is created. Changing this forces a new resource to be created."
  default = "West US"
}
variable "name" {
  description = "Name of the resource group which has to be created"
  default = "nnbediltest"
}
variable "environment" {
  description = "Classification of Dev, Test, Acceptance and Production Environments"
}

variable "costcenter" {
  description = "Cost center which will pay for the usage and consumption of resource."
}

variable "ApplicationName" {
  description = "Name of the application which will be using the resource."
}

variable "tenant_id" {
  description = "Tenant ID of the Active Directory which is authroized to access the Azure Key Vault."
}

variable "sku_name" {
  description = "SKU for the Azure Key Vault."
}

variable "rgmonitor" {
  description = "Resource group for storing the Log Analytics workspace and Storage Account"

}


variable "logworkspace" {
  description = "Log Analytics Workspace"

}


variable "storagemonitor" {
  description = "Storage Account for storing the Logs"

}