output "charlie_public_ip" {
    value = "${module.virtual_machine_charlie.public_ip}"
}
output "charlie_private_ip" {
    value = "${module.virtual_machine_charlie.private_ip}"
}
output "charlie_private_fqdn" {
    value = "${module.virtual_machine_charlie.fqdn}"
}
output "lukas_public_ip" {
    value = "${module.virtual_machine_lukas.public_ip}"
}
output "lukas_private_ip" {
    value = "${module.virtual_machine_lukas.private_ip}"
}
output "lukas_private_fqdn" {
    value = "${module.virtual_machine_lukas.fqdn}"
}