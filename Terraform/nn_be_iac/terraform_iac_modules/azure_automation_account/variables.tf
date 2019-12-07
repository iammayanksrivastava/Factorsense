variable "location" {
  description = "The location/region where the resource is created. Changing this forces a new resource to be created."
  default = "West US"
}
variable "name" {
  description = "Name of the resource group which has to be created"
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