resource "yandex_kms_symmetric_key" "kms_key" {
  name        = "kms_key"
  description = "key"
}

resource "yandex_kubernetes_cluster" "k8s_cluster" {
  name        = var.cluster_name
  description = "k8s yandex cloud"

  network_id = var.network_id

  master {

    version = "1.18"

    zonal {
      subnet_id = var.subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true
    }
  }

  service_account_id      = var.service_account_key_id
  node_service_account_id = var.node_account_key_id

  labels = {
    tag = "kubernetes"
  }

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms_key.id
  }
}
