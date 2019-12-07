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

variable "account_name" {
  description = "Account Name of the GIT Repository."
}

variable "branch_name" {
  description = "Branch name for the GIT Repository"
}

variable "project_name" {
  description = "Project Name"
}

variable "repository_name" {
  description = "repository name"
}


variable "root_folder" {
  description = "Root Folder"
}


variable "tenant_id" {
  description = "Tenant ID"
}


variable "azure_data_factory_contributor_principal_id" {
  description = "ADF Contributor Principal ID"
}


variable "subscription_id" {
  description = "Subscription ID."
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