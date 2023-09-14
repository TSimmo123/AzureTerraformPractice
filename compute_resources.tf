## Create Compute Resources

# Network Interface Card

resource "azurerm_network_interface" "NIC" {
  name                = "Nic${count.index + 1}"
  count = 2
  location            = azurerm_resource_group.azure-terraform-dev.location
  resource_group_name = azurerm_resource_group.azure-terraform-dev.name

  ip_configuration {
    name                          = "testconfig1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine

resource "azurerm_virtual_machine" "VM" {
  #  name                  = var.vm1_name
  name                  = "VM${count.index + 1}"
  count                 = 2
  location              = azurerm_resource_group.azure-terraform-dev.location
  resource_group_name   = azurerm_resource_group.azure-terraform-dev.name
  network_interface_ids = [azurerm_network_interface.NIC[count.index].id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

}
