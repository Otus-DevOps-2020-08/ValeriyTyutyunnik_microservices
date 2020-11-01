output "external_ip_addresses_docker" {
  value = yandex_compute_instance.docker.*.network_interface.0.nat_ip_address
}
