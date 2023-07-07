locals {
  userdata = base64encode(file("./cloud-init/webserver.txt"))
}

resource "random_string" "vmpassword" {
  length           = 14
  special          = true
  number           = true
  upper            = true
}

resource azurerm_network_interface NIC-Webserver {
	 name = "NIC-WS"
	 location = var.Location
	 resource_group_name = var.ResG
	 enable_ip_forwarding = false
	 enable_accelerated_networking  = false
	 #dns_servers = ["172.30.2.10"]
	 #depends_on 	=	[azurerm_linux_virtual_machine.KaliWS]
	 ip_configuration {
		 name = "nicws1"
		 subnet_id = "${azurerm_subnet.sNet-1.id}"
		 private_ip_address = "172.50.2.10"
		 private_ip_address_allocation = "Static"
         public_ip_address_id = azurerm_public_ip.PIP-Webserver.id
		 primary = true
		}
	tags = { 
	Version = var.Version
	}
}

resource "azurerm_virtual_machine" "webserver" {
  name                = "Webserver"
  resource_group_name = azurerm_resource_group.Workshop1.name
  location            = azurerm_resource_group.Workshop1.location
  vm_size                = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.NIC-Webserver.id]

  os_profile_linux_config {
    disable_password_authentication = false
  }

  os_profile {
    computer_name = "Workshopvm1"
    admin_username = "workshopadmin"
    admin_password = "${random_string.vmpassword.id}"
    custom_data = local.userdata
  }

  storage_os_disk {
      name          = "webserver"
      create_option = "FromImage"
      disk_size_gb  = "32"
      os_type       = "Linux"
      caching       = "ReadWrite"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "22.04.202204200"
  }

  provisioner "file" {
    source = "scripts/final.sh"
    destination = "/home/workshopadmin/final.sh"

    connection {
      type = "ssh"
      user = "workshopadmin"
      password = "${random_string.vmpassword.id}"
      host = "${azurerm_virtual_machine.websever.id}"
    }
  }


}
output "vm_password" {
  value = random_string.vmpassword.id
}
