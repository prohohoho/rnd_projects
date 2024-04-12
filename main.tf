
## Enable running of modules from here. Set to true if you want to run
variable "modules" {
  type = map(bool)
  default = {    
    network              = true
    compute              = true
    resource_group       = true
  }
}

module "bastion" {
  source = "./modules/bastion"

  name                    = "rnd-bastion-01"
  subnet                  = module.networking["Websites-VNET-NonPCI-01"].subnets["AzureBastionSubnet"]
  resource_group_name     = azurerm_resource_group.rg[0].name
  location                = azurerm_resource_group.rg[0].location
}