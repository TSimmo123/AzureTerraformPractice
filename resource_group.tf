## Create our Resource Group

resource "azurerm_resource_group" "azure-terraform-dev" {
  name = var.resource_group_name
  location = var.location
}