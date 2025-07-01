# Создание группы нод (Node Group)
resource "yandex_kubernetes_node_group" "node_group" {
  cluster_id = yandex_kubernetes_cluster.k8s_cluster.id
  name       = "my-node-group"
  description = "Node group for Kubernetes cluster"

  instance_template {
    platform_id = "standard-v2"
    resources {
      cores  = 2
      memory = 4
    }

    boot_disk {
      type = "network-ssd"
      size = 30
    }

    scheduling_policy {
      preemptible = true
    }

    network_interface {
      nat        = true
      subnet_ids = [for subnet in yandex_vpc_subnet.subnet : subnet.id]
      security_group_ids = [yandex_vpc_security_group.ingress_nginx.id]
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.subnet["0"].zone
    }

    location {
      zone = yandex_vpc_subnet.subnet["1"].zone
    }

    location {
      zone = yandex_vpc_subnet.subnet["2"].zone
    }
  }

  depends_on = [yandex_kubernetes_cluster.k8s_cluster , yandex_vpc_security_group.ingress_nginx]
}
