#----AZ Resource repetetive Variables Start----#
variable "name" {
  type        = string
  description = "value of the vnet name"
}
variable "location" {
  type        = string
  description = "value of the location"
}
variable "resource_group_name" {
  type        = string
  description = "value of the resource group name"
}

variable "subnet" {
  description = "subnet object that will be used"
}

# variable "public_ip" {
#   type = object({
#     name              = string
#     allocation_method = optional(string, "Static")
#     sku               = optional(string, "Standard")
#   })
#   nullable = false
# }

