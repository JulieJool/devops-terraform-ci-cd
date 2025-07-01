variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "sa_name" {
  description = "Service account name"
  type        = string
  default     = "terr-sa"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "my-vpc"
}

variable "subnets" {
  description = "Список подсетей c параметрами"
  type = list(object({
    name           = string
    zone           = string
    v4_cidr_blocks = list(string)
  }))
  default = [
    {
      name           = "subnet-a"
      zone           = "ru-central1-a"
      v4_cidr_blocks = ["10.0.1.0/24"]
    },
    {
      name           = "subnet-b"
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["10.0.2.0/24"]
    },
    {
      name           = "subnet-d"
      zone           = "ru-central1-d"
      v4_cidr_blocks = ["10.0.3.0/24"]
    }
  ]
}

variable "listener_nginx_test_app" {
  default = {
    name        = "nginx-test-app-listener"
    port        = 80
    target_port = 30088
  }
}

variable "listener_grafana" {
  default = {
    name        = "grafana-listener"
    port        = 3000
    target_port = 3000
  }
}
