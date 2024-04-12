resource "azurerm_network_interface" "nic" {
  name                = "${var.vm.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name = "${var.vm.name}-nic-ipconfig"
    #commented out the below to test compute module
    subnet_id                     = var.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
  tags = var.tags
}

resource "random_password" "password" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

# # Data template Bash bootstrapping file
# data "template_file" "linux-vm-cloud-init" {
#   template = file("debian11.sh")
# }

# locals {
#   data_inputs = {
#     heading_one = var.heading_one
#   }
# }

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm.size
  admin_username                  = var.vm.admin_username
  admin_password                  = var.vm.admin_password != null ? var.vm.admin_password : random_password.password.result
  disable_password_authentication = false
  allow_extension_operations      = true
  computer_name                   = var.vm.os_hostname
  #user_data    = base64encode("${file("debian11.sh")}")

  network_interface_ids = [
    azurerm_network_interface.nic.id]
  os_disk {
    caching              = var.vm.os_disk.caching
    storage_account_type = var.vm.os_disk.storage_account_type
    disk_size_gb         = var.vm.os_disk.os_disk_size
  }

  source_image_reference {
    publisher = var.vm.src_image_pref.publisher
    offer     = var.vm.src_image_pref.offer
    sku       = var.vm.src_image_pref.sku
    version   = var.vm.src_image_pref.version
  }
  identity {
    type = var.vm.identity
  }
  tags = var.tags
}


resource "azurerm_key_vault_secret" "vm-admin-key" {
  count        = var.akv_id != null ? 1 : 0
  name         = "${var.vm.name}-vmkeypass"
  value        = random_password.password.result
  key_vault_id = var.akv_id
}

resource "azurerm_managed_disk" "disk" {
  for_each = { for x in var.managed_disks : x.name => x if length(var.managed_disks) > 0 }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = "Premium_LRS"
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk" {
  for_each = { for x in var.managed_disks : x.name => x if length(var.managed_disks) > 0 }

  managed_disk_id    = azurerm_managed_disk.disk[each.value.name].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = each.value.lun
  caching            = each.value.caching
}

