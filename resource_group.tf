## Create our Resource Group

resource "azurerm_resource_group" "azure-terraform-dev" {
  name = "azure-terraform-dev"
  location = "UK South"
}