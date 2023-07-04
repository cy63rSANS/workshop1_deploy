resource "random_string" "storage-name" {
  length           = 10
  special          = false
  number           = false
  upper            = false
}

resource "azurerm_storage_account" "storagestijr" {
  name                     = "${random_string.storage-name.id}"
  resource_group_name      = var.ResG
  location                 = var.Location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = true
  depends_on = [azurerm_resource_group.Workshop1]

  tags = {
    Version = var.Version
  }
}
resource "azurerm_storage_container" "coupons" {
  name                  = "coupons"
  storage_account_name  = "${random_string.storage-name.id}"
  container_access_type = "blob"
  depends_on = [azurerm_storage_account.storagestijr]
}
resource "azurerm_storage_blob" "coupons" {
  for_each = fileset(path.module, "flight_coupons/*")
 
  name                   = each.key
  storage_account_name   = azurerm_storage_account.storagestijr.name
  storage_container_name = azurerm_storage_container.coupons.name
  type                   = "Block"
  source                 = each.key
}
output "storage_account_primary_access_key" {
  value = data.azurerm_storage_account.storagestijr.primary_access_key
}
output "storage_account_name" {
  value = data.azurerm_storage_account.storagestijr.name
}