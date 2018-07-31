module "storage" {
  source = "../az-storage"
  name = "${var.storage_account_name}"
  location = "eastus2"
  resource_group_name = "${var.resource_group_name}"
  containers = ["other", "vhds"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name_prefix}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "ip-config-main"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}
