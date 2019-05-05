module "storage" {
  source = "../az-storage"
  name = "${var.storage_account_name}"
  location = "eastus2"
  resource_group_name = "${var.resource_group_name}"
  containers = ["other", "vhds"]
}
resource "azurerm_public_ip" "main" {
  name                         = "${var.vm_name_prefix}-pip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  domain_name_label            = "${var.vm_name_prefix}"
  public_ip_address_allocation = "Dynamic"
  idle_timeout_in_minutes      = 30

  tags {
    environment = "test"
  }
}
resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name_prefix}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "ip-config-main"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.main.id}"
  }
}
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.vm_name_prefix}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_DS2_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name_prefix}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.vm_name_prefix}"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    idle = "true"
  }
}
data "azurerm_public_ip" "main" {
  name                = "${azurerm_public_ip.main.name}"
  resource_group_name = "${var.resource_group_name}"
}