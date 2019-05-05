resource "azurerm_resource_group" "network" {
  name     = "AZ-RG-Network-EUS2"
  location = "eastus2"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "AZ-NSG-Network-EUS2"
  location            = "${azurerm_resource_group.network.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"
}

resource "azurerm_network_security_rule" "ssh_inbound" {
  name                        = "ssh_inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.network.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
resource "azurerm_network_security_rule" "rdp_inbound" {
  name                        = "rdp_inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.network.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
resource "azurerm_virtual_network" "network" {
  name                = "AZ-VN-Network-EUS2"
  resource_group_name = "${azurerm_resource_group.network.name}"
  address_space       = ["10.0.0.0/24"]
  location            = "${azurerm_resource_group.network.location}"
  dns_servers         = ["10.0.0.4", "10.0.0.5", "8.8.8.8", "8.8.4.4"]
}
resource "azurerm_subnet" "subnet1" {
  name           = "subnet1"
  resource_group_name = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix = "10.0.0.0/26"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}

resource "azurerm_subnet" "subnet2" {
  name           = "subnet2"
  resource_group_name = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix = "10.0.0.64/26"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}
resource "azurerm_subnet" "subnet3" {
  name           = "subnet3"
  resource_group_name = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix = "10.0.0.128/26"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}
resource "azurerm_subnet" "subnet4" {
  name           = "subnet4"
  resource_group_name = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix = "10.0.0.192/26"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}
resource "azurerm_role_assignment" "authZ" {
  count = "${length(var.users)}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id       = "${var.users[count.index]}"
  scope              = "${azurerm_resource_group.network.id}"
}
