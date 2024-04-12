network_configurations = {

  Websites-VNET-NonPCI-01 = {
    location            = "Australia East"
    resource_group_name = "Websites-Prod-RG"
    address_space       = ["10.217.2.0/24"]
    subnets = {
      Web-subnet-01 = {
        name             = "Web-subnet-01"
        nsgname          = "Web-subnet-01-nsg"
        address_prefixes = ["10.217.2.0/26"]
        rules = {
          AllowSShRDPBastionOutbound = {
            name                       = "AllowSsHRdpBastionOutbound"
            priority                   = 300
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_address_prefix      = "*"
            destination_port_ranges    = [22, 3389]
            source_port_range          = "*"
            destination_address_prefix = "VirtualNetwork"
          }
          AllowAzCloudBastionOutbound = {
            name                       = "AllowAzCloudBastionOutbound"
            priority                   = 310
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_address_prefix      = "*"
            source_port_range          = "*"
            destination_port_range     = 443
            destination_address_prefix = "AzureCloud"
          }
          AllowBastionCommsOutbound = {
            name                       = "AllowBastionCommsOutbound"
            priority                   = 320
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_address_prefix      = "VirtualNetwork"
            destination_port_ranges    = [8080, 5701]
            source_port_range          = "*"
            destination_address_prefix = "VirtualNetwork"
          }
          AllowHttpOutbound = {
            name                       = "AllowHttpOutbound"
            priority                   = 330
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_address_prefix      = "*"
            destination_port_ranges    = [80]
            source_port_range          = "*"
            destination_address_prefix = "Internet"
          }

          AllowBastionHttpsInbound = {
            name                       = "AllowBastionHttpsInbound"
            priority                   = 310
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_address_prefix      = "Internet"
            source_port_range          = "*"
            destination_port_range     = 443
            destination_address_prefix = "*"
          }
          AllowBastionGatewayInbound = {
            name                       = "AllowBastionGatewayInbound"
            priority                   = 320
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_address_prefix      = "GatewayManager"
            source_port_range          = "*"
            destination_port_range     = 443
            destination_address_prefix = "*"
          }
          AllowBastionLBInbound = {
            name                       = "AllowBastionLBInbound"
            priority                   = 330
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_address_prefix      = "AzureLoadBalancer"
            source_port_range          = "*"
            destination_port_range     = 443
            destination_address_prefix = "*"
          }
          AllowBastionDataPlaneInbound = {
            name                       = "AllowBastionDataPlaneInbound"
            priority                   = 340
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "*"
            source_address_prefix      = "VirtualNetwork"
            destination_port_ranges    = [8080, 5701]
            source_port_range          = "*"
            destination_address_prefix = "VirtualNetwork"
          }
        }

      },
      AzureBastionSubnet = {
        address_prefixes = ["10.217.2.64/26"]
      }
    }
  }
}
