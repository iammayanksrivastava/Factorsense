variable "subnet" {
  description = "Subnet for the environment"
}

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

variable "subscription_id" {
  description = "Subscription ID."
}


variable "storage_account_contributor_principal_id" {
  description = "Subscription ID."
}


variable "tenant_id" {
  description = "Active Directory"

}

variable "sku_name" {
  description = "SKU Name for the Azure Key Vault"

}


variable "account_name" {
  description = "Account Name of the GIT Repository."
}

variable "branch_name" {
  description = "Branch name for the GIT Repository"
}

variable "project_name" {
  description = "Name of the GIT Project"
}

variable "repository_name" {
  description = "repository name"
}

variable "root_folder" {
  description = "Root Folder"
}

variable "azure_data_factory_contributor_principal_id" {
  description = "ADF Contributor Principal ID"
}

variable "sql_administrator" {
    description = "Azure Active Directory authentication allows you to centrally manage identity and access to your Azure SQL Database V12."

}

variable "rule_1_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_2_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_3_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_4_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_5_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_6_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_7_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_8_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_9_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_10_name" {
  description = "Name of the Firewall Rule"
}

variable "rule_1_start_ip" {
  description = "Start IP Address"

}


variable "rule_1_end_ip" {
  description = "End IP Address"

}



variable "rule_2_start_ip" {
  description = "Start IP Address"

}


variable "rule_2_end_ip" {
  description = "End IP Address"

}



variable "rule_3_start_ip" {
  description = "Start IP Address"

}


variable "rule_3_end_ip" {
  description = "End IP Address"

}



variable "rule_4_start_ip" {
  description = "Start IP Address"

}


variable "rule_4_end_ip" {
  description = "End IP Address"

}



variable "rule_5_start_ip" {
  description = "Start IP Address"

}


variable "rule_5_end_ip" {
  description = "End IP Address"

}



variable "rule_6_start_ip" {
  description = "Start IP Address"

}


variable "rule_6_end_ip" {
  description = "End IP Address"

}



variable "rule_7_start_ip" {
  description = "Start IP Address"

}


variable "rule_7_end_ip" {
  description = "End IP Address"

}



variable "rule_8_start_ip" {
  description = "Start IP Address"

}


variable "rule_8_end_ip" {
  description = "End IP Address"

}



variable "rule_9_start_ip" {
  description = "Start IP Address"

}


variable "rule_9_end_ip" {
  description = "End IP Address"

}



variable "rule_10_start_ip" {
  description = "Start IP Address"

}


variable "rule_10_end_ip" {
  description = "End IP Address"

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

variable "vm_admin_password" {
  description = "Password for the admin account on the VM"
}