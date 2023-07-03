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
  allow_blob_public_access = true
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
