compute = { 
  Websites-VM-Drupal7-Az1-01 = {
    subnet_name = "Web-subnet-01"
    vnet_key   =  "Websites-VNET-NonPCI-01"
    vm = {
      name           = "Websites-VM-Drupal7-Az1-01"
      os_hostname    = "Drupal7-Az1-01"
      size           = "Standard_DS1_v2"
      admin_username = "temp_user_123!"
      admin_password = "sup3rSecretvm!"
      os_disk = {
        os_disk_size = "100"
      }
      src_image_pref = {
        offer     = "0001-com-ubuntu-server-jammy"
        publisher = "Canonical"
        sku       = "22_04-lts-gen2"
        version   = "latest"
      }
      recovery_vault_name = null
    }
  }
}

