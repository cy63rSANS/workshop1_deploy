resource azurerm_network_security_group nsg_webserver {
	 name = "NSG1"
	 location = var.Location
	 resource_group_name = var.ResG	
	 security_rule {
		 name = "WebApp_Inbound"
		 access = "Allow"
		 priority = "2010"
		 protocol = "*"
		 direction = "Inbound"
		 source_port_range = "*"
		 source_address_prefix = "*"
		 destination_port_ranges = ["80", "8080"]
		 destination_address_prefixes = ["172.50.2.10"]
	}
	 security_rule {
		 name = "MGT_Inbound"
		 access = "Allow"
		 priority = "2000"
		 protocol = "*"
		 direction = "Inbound"
		 source_port_range = "*"
		 source_address_prefix = "*"
		 destination_port_ranges = ["22"]
		 destination_address_prefixes = ["172.50.2.10"]
	}

	depends_on = [azurerm_virtual_machine.webserver]
	tags = { 
	Version = var.Version
}
}
resource azurerm_subnet_network_security_group_association sNet-Asoc1 {
	subnet_id = "${azurerm_subnet.sNet-1.id}"
	network_security_group_id = "${azurerm_network_security_group.nsg_webserver.id}"
}