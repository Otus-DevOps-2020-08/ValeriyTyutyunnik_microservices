provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  version                  = "~> 0.35"
}

module "vpc" {
  source = "../modules/vpc"
}

module "cluster" {
  source                 = "../modules/k8s_cluster"
  network_id             = module.vpc.k8s_network_id
  subnet_id              = module.vpc.k8s_subnet_id
  service_account_key_id = var.service_account_id
  node_account_key_id    = var.service_account_id
  cluster_name           = "k8s-yc-cluster"
}

module "node_group" {
  source         = "../modules/k8s_node_group"
  k8s_cluster_id = module.cluster.k8s_cluster_id
}
