output "k8s_network_id" {
  value = yandex_vpc_network.k8s_network.id
}

output "k8s_subnet_id" {
  value = yandex_vpc_subnet.k8s_subnet.id
}
