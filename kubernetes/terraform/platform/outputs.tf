output "cluster_external_ip" {
  value = module.cluster.k8s_external_ip
}

output "cluster_init_command" {
  value = "yc managed-kubernetes cluster get-credentials ${module.cluster.name} --external"
}
