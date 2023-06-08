//network security group
resource "azurerm_network_security_group" "test_NSG" {
    name                = "${var.airline_name}-CN3-MA01-nsg"
    location            = azurerm_resource_group.new_airline_rg.location
    resource_group_name = azurerm_resource_group.new_airline_rg.name

    tags = {
        owner= "FPT"
        environment = "test"
    }
}

# //virtual network
resource "azurerm_virtual_network" "test_virtual_network" {
    name                = "RG_${var.airline_name}-Vnet"
    location            = azurerm_resource_group.new_airline_rg.location
    resource_group_name = azurerm_resource_group.new_airline_rg.name
    address_space       = ["0.0.0.0/24"]

    tags = {
        owner= "FPT"
        environment = "test"
    }
}


# //subnet    
resource "azurerm_subnet" "test_subnet" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.new_airline_rg.name
  virtual_network_name = azurerm_virtual_network.test_virtual_network.name
  address_prefixes     = ["0.0.0.0/28"]
  service_endpoints = ["Microsoft.Storage","Microsoft.keyVault"]
}

# //network interface
# ////Configuring later
# resource "azurerm_network_interface" "test_nic" {
#   name                = "airline-nic"
#   location            = azurerm_resource_group.new_airline_rg.location
#   resource_group_name = azurerm_resource_group.new_airline_rg.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.test_subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# //firewall
# # resource "azurerm_firewall" "example" {
# #   name                = "testfirewall"
# #   location            = azurerm_resource_group.example.location
# #   resource_group_name = azurerm_resource_group.example.name
# #   sku_name            = "AZFW_VNet"
# #   sku_tier            = "Standard"

# #   ip_configuration {
# #     name                 = "configuration"
# #     subnet_id            = azurerm_subnet.example.id
# #     public_ip_address_id = azurerm_public_ip.example.id
# #   }
# # }

# //firewall policy
# # resource "azurerm_firewall_policy" "example" {
# #   name                = "example-policy"
# #   resource_group_name = azurerm_resource_group.example.name
# #   location            = azurerm_resource_group.example.location
# # }


# # //private endpoint
# # resource "azurerm_private_endpoint" "example" {
# #   name                = "example-endpoint"
# #   location            = azurerm_resource_group.example.location
# #   resource_group_name = azurerm_resource_group.example.name
# #   subnet_id           = azurerm_subnet.endpoint.id

# #   private_service_connection {
# #     name                           = "example-privateserviceconnection"
# #     private_connection_resource_id = azurerm_private_link_service.example.id
# #     is_manual_connection           = false
# #   }
# # }

# //route table
# # resource "azurerm_route_table" "example" {
# #   name                          = "example-route-table"
# #   location                      = azurerm_resource_group.example.location
# #   resource_group_name           = azurerm_resource_group.example.name
# #   disable_bgp_route_propagation = false

# #   route {
# #     name           = "route1"
# #     address_prefix = "10.1.0.0/16"
# #     next_hop_type  = "VnetLocal"
# #   }

# #   tags = {
# #     environment = "Production"
# #   }
# # }

# //peering
# # resource "azurerm_virtual_network_peering" "example-1" {
# #   name                      = "peer1to2"
# #   resource_group_name       = azurerm_resource_group.example.name
# #   virtual_network_name      = azurerm_virtual_network.example-1.name
# #   remote_virtual_network_id = azurerm_virtual_network.example-2.id
# # }