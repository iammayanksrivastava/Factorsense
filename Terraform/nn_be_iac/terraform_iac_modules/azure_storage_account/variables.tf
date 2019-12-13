variable "name" {
  description = "Name of the resource group which has to be created"
}

variable "location" {
  description = "The location/region where the resource is created. Changing this forces a new resource to be created."
  default = "West US"
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


variable "account_tier" {
  description = "Account Tier for the storage Account"
}

variable "replication_type" {
  description = "Replication type for the storage account"
}

variable "accountkind" {
  description = "Kind of account for the storage account."
}

variable "subscription_id" {
  description = "Subscription ID."
}


variable "storage_account_contributor_principal_id" {
  description = "Subscription ID."
}


