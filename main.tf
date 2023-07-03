resource azurerm_resource_group Workshop1 {
	name = var.ResG
	location = var.Location
		tags = { 
			CreatedDate = timestamp()
            Version = var.Version
		}
}

resource azurerm_virtual_network vNet {
	name = "Network1"
	location = var.Location
	resource_group_name = var.ResG
	depends_on = [azurerm_resource_group.Workshop1]
	address_space =  ["172.50.0.0/20",]	

}

resource azurerm_subnet sNet-1 {
	 name = "SubNet1"
	 virtual_network_name = "Network1"
	 resource_group_name = var.ResG
	 address_prefixes = ["172.50.2.0/24"]
     depends_on = [azurerm_virtual_network.vNet]
	 service_endpoints = ["Microsoft.Web"]

}

resource azurerm_subnet GatewaySubnet {
	 name = "GatewaySubnet"
	 virtual_network_name = "Network1"
	 resource_group_name = var.ResG
	 address_prefixes = ["172.50.1.0/28"]
	 service_endpoints = []	
     depends_on = [azurerm_virtual_network.vNet]
} 

resource azurerm_public_ip PIP-Webserver {
	 name = "PIP-Webserver"
	 location = var.Location
	 resource_group_name = var.ResG
	 sku = "Basic"
	 #domain_name_label = var.PlayerDNS
	 allocation_method   = "Dynamic"
     depends_on = [azurerm_resource_group.Workshop1]
}




