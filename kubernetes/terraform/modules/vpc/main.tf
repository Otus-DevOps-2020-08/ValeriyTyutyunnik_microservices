resource "yandex_vpc_network" "k8s_network" {
  name = "k8s-network"
  labels = {
    tag = "kubernetes"
  }
}

resource "yandex_vpc_subnet" "k8s_subnet" {
  name = "k8s-subnet"
  labels = {
    tag = "kubernetes"
  }

  network_id     = yandex_vpc_network.k8s_network.id
  v4_cidr_blocks = ["10.100.0.0/24"]
}
