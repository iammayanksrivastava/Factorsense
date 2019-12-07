########################################################################################################
# Create Automation Account     
########################################################################################################
resource "azurerm_automation_account" "automationaccount" {
  name                = "${var.name}automationaccount"
  location            = "${var.location}"
  resource_group_name = "${var.name}rg"

  sku_name = "Basic"

    tags = {
    environment     = "${var.environment}"
    costcenter      = "${var.costcenter}"
    ApplicationName = "${var.ApplicationName}"
  }
}