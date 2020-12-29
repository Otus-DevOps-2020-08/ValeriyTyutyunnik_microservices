output "k8s_external_ip" {
  value = yandex_kubernetes_cluster.k8s_cluster.master[0].public_ip
}

output "k8s_cluster_id" {
  value = yandex_kubernetes_cluster.k8s_cluster.id
}

output "name" {
  value = yandex_kubernetes_cluster.k8s_cluster.name
}
