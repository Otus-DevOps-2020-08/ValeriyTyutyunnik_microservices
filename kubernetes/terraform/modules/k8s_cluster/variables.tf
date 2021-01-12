variable network_id {
  description = "network id"
}

variable subnet_id {
  description = "subnet id"
}

variable service_account_key_id {
  description = "Service account key id for cluster"
}

variable node_account_key_id {
  description = "Service account key id for node. Can be similar to service account key"
}

variable cluster_name {
  description = "Cluster name"
  default     = "k8s-cluster"
}
