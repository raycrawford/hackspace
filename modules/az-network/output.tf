output "vnet" {
  value = "${azurerm_virtual_network.network.id}"
}
output "subnet1" {
  value = "${azurerm_subnet.subnet1.id}"
}
output "subnet2" {
  value = "${azurerm_subnet.subnet2.id}"
}
output "subnet3" {
  value = "${azurerm_subnet.subnet3.id}"
}
output "subnet4" {
  value = "${azurerm_subnet.subnet4.id}"
}
