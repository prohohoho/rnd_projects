variable "location" {
  description = "value of the location"
  type        = string
  nullable    = false
}
variable "resource_group_name" {
  description = "value of the resource group name"
  type        = string
  nullable    = false
}

variable "subnet" {
  description = "value of the subnet"
}

variable "akv_id" {
  description = "value of the akv id"
  type        = string
  nullable    = true
}

variable "vm" {
  type = object({
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
      os_disk_size         = string
    })
    src_image_pref = object({
      publisher = optional(string)
      offer     = optional(string)
      sku       = optional(string)
      version   = optional(string)
    })
  })
  nullable = false
}



variable "managed_disks" {
  default     = {}
  description = "List of managed disks to add to the VM"
}



variable "private_ip_address_allocation" {
  default = "Dynamic"
}


variable "tags" {
  type = object({
    environment            = optional(string)
    backup                 = optional(string)
    patching               = optional(string)
    VeeambackupapplianceID = optional(string)
  })
  default     = null
  description = "List of tags"
}

