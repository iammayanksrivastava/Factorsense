variable "name" {
  description = "Name of the resource group which has to be created"
}

variable "location" {
  description = "The location/region where the resource is created. Changing this forces a new resource to be created."
}

variable "environment" {
  description = "Classification of Dev, Test, Acceptance and Production Environments"
}

variable "costcenter" {
  description = "Cost center which will pay for the usage and consumption of resource."
}

variable "ApplicationName" {
  description = "Cost center which will pay for the usage and consumption of resource."
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
}

variable "vm_image_version" {
  description = "VM Image from SOS Gallery"
}


variable "vm_admin" {
  description = "Admin Account for the Virtual Machine"
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