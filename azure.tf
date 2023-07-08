terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.63.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
      virtual_machine {
        delete_os_disk_on_deletion     = true
        graceful_shutdown              = false
        skip_shutdown_and_force_delete = true
      }
      log_analytics_workspace {
        permanently_delete_on_destroy = true
    }
}