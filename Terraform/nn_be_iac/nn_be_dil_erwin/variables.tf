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

variable "vm_image_version" {
  description = "VM Image from SOS Gallery"
}

variable "admin_username" {
  description = "Admin Account for the Virtual Machine"
}

variable "subnet" {
  description = "Subnet where you would want to deploy the VM"
}