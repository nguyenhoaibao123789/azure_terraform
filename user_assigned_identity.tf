resource "azurerm_user_assigned_identity" "test-UMA" {
  location            = azurerm_resource_group.new_airline_rg.location
  name                = "${var.airline_name}-UMA"
  resource_group_name = azurerm_resource_group.new_airline_rg.name

  tags = {
    env="test"
    owner="FPT"
  }
}