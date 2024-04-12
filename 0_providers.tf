terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = "~>1.7.0"
}


provider "azurerm" {
  features {
    # key_vault {
    #   purge_soft_delete_on_destroy = true
    # }
  }
}
