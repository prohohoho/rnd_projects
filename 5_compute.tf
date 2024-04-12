module "linux-VM" {
  source = "./modules/compute"
  for_each = {
    for k, v in var.compute : k => v
    if var.modules.compute
  }

  location             = each.value.location != null ? each.value.location : var.location
  resource_group_name  = each.value.resource_group_name != null ? each.value.resource_group_name : azurerm_resource_group.rg[0].name
  subnet               = module.networking[each.value.vnet_key].subnets[each.value.subnet_name]
  akv_id               = null
  vm                   = each.value.vm
  managed_disks        = {}
}
 
