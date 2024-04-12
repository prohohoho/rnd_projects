variable "network_configurations" {
  type = map(object({
    location      = optional(string, "australiaeast")
    resource_group_name     = optional(string)
    address_space = list(string)
    subnets = map(object({
      nsgname           = optional(string, null)
      address_prefixes  = list(string)
      service_endpoints = optional(list(string), null)
      delegation = optional(object({
        name                       = optional(string)
        service_delegation_name    = optional(string)
        service_delegation_actions = optional(list(string), [])
      }), null)
      rules = optional(map(object({
        priority                                   = number
        direction                                  = string
        access                                     = string
        protocol                                   = string
        source_port_range                          = optional(string)
        source_port_ranges                         = optional(list(string))
        source_address_prefix                      = optional(string)
        source_address_prefixes                    = optional(list(string))
        source_application_security_group_ids      = optional(list(string))
        destination_port_range                     = optional(string)
        destination_port_ranges                    = optional(list(string))
        destination_address_prefix                 = optional(string)
        destination_address_prefixes               = optional(list(string))
        destination_application_security_group_ids = optional(list(string))
      })))
    }))
  }))
}

variable "compute" {
  type = map(object({
    location                      = optional(string, "australiaeast")
    resource_group_name           = optional(string)
    subnet_name                   = optional(string)
    vnet_key                      = optional(string)
    akv_key                       = optional(string)
    private_ip_address_allocation = optional(string)
    vm = object({
      name                            = optional(string)
      os_hostname                     = optional(string)
      size                            = optional(string)
      admin_username                  = optional(string)
      admin_password                  = optional(string)
      identity                        = optional(string, "SystemAssigned")
      disable_password_authentication = optional(bool, false)
      allow_extension_operations      = optional(bool, true)
      os_disk = object({
        caching              = optional(string, "ReadWrite")
        storage_account_type = optional(string, "Premium_LRS")
        os_disk_size         = optional(string)
      })
      src_image_pref = object({
        publisher = optional(string)
        offer     = optional(string)
        sku       = optional(string)
        version   = optional(string)
      })
    })
    # managed_disks = optional(set(object({
    #   disk_size_gb  = optional(string)
    #   disk_type     = optional(string, "Premium_LRS")
    #   create_option = optional(string)
    # })))
    # data_disk_attachment = optional(set(object({
    #   lun     = number
    #   caching = string
    # })))
    recovery_vault_name = optional(string)
    backup_policy_id    = optional(string)
  }))
}