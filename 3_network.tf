module "networking" {
  source = "./modules/networking"
  for_each = {
    for k, v in var.network_configurations : k => v
    if var.modules.network
  }

  environment         = var.environment
  resource_group_name     = each.value.resource_group_name != null ? each.value.resource_group_name : azurerm_resource_group.rg[0].name
  location                = each.value.location != null ? each.value.location : azurerm_resource_group.rg[0].location
  vnet_name           = each.key
  address_space       = each.value.address_space
  subnets             = each.value.subnets
}

