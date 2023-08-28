
##########################################################################################
# Virtual Network
##########################################################################################
resource "azurerm_virtual_network" "trainee-window-Vnet" {
  name                = "trainee-window-Vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "SoutheastAsia"
  resource_group_name = "rg-ais-payment-gateway"
  tags = merge(
     var.env_tags
   )
}
############################ subnet ##########################
resource "azurerm_subnet" "network" {
  name                 = "trainee-window-Subnet"
  resource_group_name  = "rg-ais-payment-gateway"
  virtual_network_name = azurerm_virtual_network.trainee-window-Vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


##########################################################################################
# Security Group
##########################################################################################
resource "azurerm_network_security_group" "sg" {
  name                = "trainee-NetworkSecurityGroup"
  location            = "SoutheastAsia"
  resource_group_name = "rg-ais-payment-gateway"

  security_rule {
    name                       = "SSHPort"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    tags = merge(
     var.env_tags
   )

}

##########################################################################################
# Network Interface
##########################################################################################
 resource "azurerm_network_interface" "net" {
  name                = "trainee-NIC"
  location            = "SoutheastAsia"
  resource_group_name = "rg-ais-payment-gateway"
   tags = merge(
    var.env_tags
   )

   ip_configuration {
     name                          = "trainee-ip-config"
     subnet_id                     = resource.azurerm_subnet.network.id
     private_ip_address_allocation = "Dynamic"
   }
 }


resource "azurerm_windows_virtual_machine" "vm" {
   count                 = var.instance_count
   name                  = "trainee-vm-window"
   location            = "southeastasia"
   resource_group_name = "rg-ais-payment-gateway"
   network_interface_ids = [azurerm_network_interface.net.id]
   size                  = var.vm_size
   admin_username        = var.os_admin_username
   admin_password        = var.os_admin_password
   hotpatching_enabled   = false
   # Uncomment this line to delete the OS disk automatically when deleting the VM


   # Uncomment this line to delete the data disks automatically when deleting the VM
  #  delete_data_disks_on_termination = true

  source_image_reference {
    publisher = var.SRC_IMG_REF_PUBLISHER
    offer     = var.SRC_IMG_REF_OFFER
    sku       = var.SRC_IMG_REF_SKU
    version   = var.SRC_IMG_REF_VERSION
  }

   os_disk {
     caching              = "ReadWrite"
     storage_account_type = "Standard_LRS"
   }

   timezone = "SE Asia Standard Time"

   tags = merge(
    var.env_tags
   )
   depends_on = [
    azurerm_network_security_group.sg,
    azurerm_network_interface.net
  ]
 }

 resource "azurerm_network_interface_security_group_association" "networkassociation" {
  count                     = var.instance_count 
  network_interface_id      = azurerm_network_interface.net.id
  network_security_group_id = azurerm_network_security_group.sg.id
  depends_on = [
    azurerm_network_security_group.sg,
    azurerm_network_interface.net
  ]
}
 

