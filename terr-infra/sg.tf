resource "yandex_vpc_security_group" "ingress_nginx" {
  name        = "ingress-nginx-sg"
  description = "Правила группы обеспечивают базовую работоспособность кластера Managed Service for Kubernetes"
  network_id  = yandex_vpc_network.network.id

  # Временно разрешаем весь входящий трафик
  ingress {
    protocol       = "ANY"
    description    = "Временно разрешает весь входящий трафик для диагностики."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  # Исходящий трафик
  egress {
    protocol       = "ANY"
    description    = "Разрешает весь исходящий трафик."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
