resource "azurerm_public_ip" "bastion" {
  name                = "${var.name}-bastion-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "vm-bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}