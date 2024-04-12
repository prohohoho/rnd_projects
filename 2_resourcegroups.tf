resource "azurerm_resource_group" "rg" {
  count    = var.modules.resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

