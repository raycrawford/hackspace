variable "location" {
  default = "eastus2"
}
variable "charlie" {
  type = "string"
  default = "87209aad-775a-4228-82fa-25b1edf24a2e"
}
variable "lukas" {
  type = "string"
  default = "02abf62a-212d-49e5-ac5b-0ed7b47b6ee0"
}
variable "users" {
  default = ["87209aad-775a-4228-82fa-25b1edf24a2e", "02abf62a-212d-49e5-ac5b-0ed7b47b6ee0"]
}
module "charlies_bucket" {
  source = "./modules/az-resource_groups"
  resource_group_name = "charlie"
  location = "${var.location}"
  owner = "${var.charlie}"
}

module "lukas_bucket" {
  source = "./modules/az-resource_groups"
  resource_group_name = "lukas"
  location = "${var.location}"
  owner = "${var.lukas}"
}

module "network" {
  source = "./modules/az-network"
  users = "${var.users}"
}

module "virtual_machine" {
  source = "./modules/az-virtual_machine"
  location = "${var.location}"
  resource_group_name = "lukas"
  vm_name_prefix = "lrc-lin-01"
  subnet_id = "${module.network.subnet1}"
  storage_account_name = "boys"
}
