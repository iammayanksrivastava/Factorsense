########################################################################################################
# Subscription    
########################################################################################################

data "azurerm_subscription" "primary" {}

########################################################################################################
# Create Custom Role for Virtual Machine Operator    
########################################################################################################


resource "azurerm_role_definition" "vmoperator" {
  name        = "DIL Virtual Machine Operator"
  scope       = "${data.azurerm_subscription.primary.id}"
  description = "This is a custom role created via Terraform to allow the DevOps Enginner Start and Shutdown the Virtual Machine"

  permissions {
    actions     = [
    "Microsoft.Storage/*/read",
    "Microsoft.Network/*/read",
    "Microsoft.Compute/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Compute/virtualMachines/deallocate/action",
    "Microsoft.Authorization/*/read",
    "Microsoft.ResourceHealth/availabilityStatuses/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Insights/alertRules/*",
    "Microsoft.Insights/diagnosticSettings/*",
    "Microsoft.Support/*"]
    not_actions = []
  }

  assignable_scopes = [
    "${data.azurerm_subscription.primary.id}", 
  ]
}