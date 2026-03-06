resource "azurerm_resource_group" "anil-rg" {
  name     = "${var.rgname}"
  location = var.location
}

resource "azurerm_virtual_network" "anil-vnet" {
  name                = "${var.rgname}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.anil-rg.location
  resource_group_name = azurerm_resource_group.anil-rg.name
}

resource "azurerm_subnet" "anil-subnet" {
  name                 = "${var.rgname}-subnet"
  resource_group_name  = azurerm_resource_group.anil-rg.name
  virtual_network_name = azurerm_virtual_network.anil-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "anil-nic" {
  name                = "${var.rgname}-nic"
  location            = azurerm_resource_group.anil-rg.location
  resource_group_name = azurerm_resource_group.anil-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.anil-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "anil-vm" {
  name                = "${var.rgname}-vm1"
  location            = azurerm_resource_group.anil-rg.location
  resource_group_name = azurerm_resource_group.anil-rg.name
  network_interface_ids = [azurerm_network_interface.anil-nic.id]
  vm_size               = "Standard_B2s"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.rgname}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.rgname}-vm"
    admin_username = "adminuser"
    admin_password = "AdminPassword123!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  
  }
  tags = { 
    environment = "dev"
   }
}