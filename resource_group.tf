## Create our Resource Group

resource "azurerm_resource_group" "azure-terraform-dev" {
  name     = var.rg_name
  location = var.location
}