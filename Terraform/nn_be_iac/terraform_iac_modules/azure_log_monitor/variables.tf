variable "location" {
  description = "The location/region where the resource is created. Changing this forces a new resource to be created."
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

variable "application" {
  description = "Name of the application which will be using the resource."
}


variable "account_tier" {
  description = "Account Tier for the storage Account"
}

variable "replication_type" {
  description = "Replication type for the storage account"
}

variable "accountkind" {
  description = "Kind of account for the storage account."
}
