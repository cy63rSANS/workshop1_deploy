resource "azurerm_log_analytics_workspace" "fAirLineLogs" {
  name                = "FAitLine_Logs"
	location = var.Location
	resource_group_name = var.ResG	
  sku                 = "PerGB2018"
  retention_in_days   = 30
}