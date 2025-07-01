# Создание кластера Kubernetes
resource "yandex_kubernetes_cluster" "k8s_cluster" {
  name        = "my-k8s-cluster"
  description = "Regional Kubernetes cluster"
  network_id  = yandex_vpc_network.network.id

  master {
    version = "1.31"
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.subnet["0"].zone
        subnet_id = yandex_vpc_subnet.subnet["0"].id
      }

      location {
        zone      = yandex_vpc_subnet.subnet["1"].zone
        subnet_id = yandex_vpc_subnet.subnet["1"].id
      }

      location {
        zone      = yandex_vpc_subnet.subnet["2"].zone
        subnet_id = yandex_vpc_subnet.subnet["2"].id
      }
    }

    public_ip = true # Обеспечивает доступ к мастеру из интернета
  }

  service_account_id      = data.terraform_remote_state.setup.outputs.service_account_id
  node_service_account_id = data.terraform_remote_state.setup.outputs.service_account_id
  depends_on              = [yandex_vpc_subnet.subnet]
}
