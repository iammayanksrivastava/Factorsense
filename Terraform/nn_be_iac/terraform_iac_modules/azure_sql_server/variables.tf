variable "name" {
  description = "Name of the resource group which has to be created"
  default = "nnbediltest"
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

variable "sql_administrator" {
    description = "Azure Active Directory authentication allows you to centrally manage identity and access to your Azure SQL Database V12."

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

variable "rgmonitor" {
  description = "Resource group for storing the Log Analytics workspace and Storage Account"

}


variable "logworkspace" {
  description = "Log Analytics Workspace"

}


variable "storagemonitor" {
  description = "Storage Account for storing the Logs"

}