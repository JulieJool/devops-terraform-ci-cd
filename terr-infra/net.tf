# Создание VPC
resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}

# Создание подсетей в разных зонах доступности
resource "yandex_vpc_subnet" "subnet" {
  for_each = { for idx, subnet in var.subnets : idx => subnet }

  name           = each.value.name
  zone           = each.value.zone
  v4_cidr_blocks = each.value.v4_cidr_blocks
  network_id     = yandex_vpc_network.network.id
}
