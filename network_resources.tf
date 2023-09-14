## Create Network Resources

# Network Security Group

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.azure-terraform-dev.location
  resource_group_name = azurerm_resource_group.azure-terraform-dev.name

  security_rule {
    name                       = "AllowInternetOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Virtual Network

resource "azurerm_virtual_network" "VNet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.azure-terraform-dev.location
  resource_group_name = azurerm_resource_group.azure-terraform-dev.name
  address_space       = ["10.0.0.0/16"]
}
# Subnet
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.azure-terraform-dev.name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet
resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.azure-terraform-dev.name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# NSG Association

resource "azurerm_subnet_network_security_group_association" "NSG-association" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg.id

}

resource "azurerm_public_ip" "publicip" {
  name                = "publicip"
  location            = azurerm_resource_group.azure-terraform-dev.location
  resource_group_name  = azurerm_resource_group.azure-terraform-dev.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "Bastion-host" {
  name                = "examplebastion"
  location            = azurerm_resource_group.azure-terraform-dev.location
  resource_group_name  = azurerm_resource_group.azure-terraform-dev.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet1.id
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}




