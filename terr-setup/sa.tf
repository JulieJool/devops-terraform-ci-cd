# Создание сервисного аккаунта
resource "yandex_iam_service_account" "terr-sa" {
  folder_id   = var.folder_id
  name        = "terr-sa"
  description = "Service account for Terraform with necessary permissions"
}

# Назначение роли 
resource "yandex_resourcemanager_folder_iam_member" "editor-sa" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.terr-sa.id}"
  depends_on = [yandex_iam_service_account.terr-sa]
}

# Назначение роли vpc.publicAdmin
resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin-sa" {
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.terr-sa.id}"
  depends_on = [yandex_iam_service_account.terr-sa]
}

# Назначение роли alb.admin
resource "yandex_resourcemanager_folder_iam_member" "alb-admin-sa" {
  folder_id = var.folder_id
  role      = "alb.admin"
  member    = "serviceAccount:${yandex_iam_service_account.terr-sa.id}"
  depends_on = [yandex_iam_service_account.terr-sa]
}

# Создание статического ключа доступа для сервисного аккаунта
resource "yandex_iam_service_account_static_access_key" "terr-sa-static-key" {
  service_account_id = yandex_iam_service_account.terr-sa.id
  description        = "Static access key for terr-sa"
}

resource "yandex_iam_service_account_key" "sa_key" {
  service_account_id = yandex_iam_service_account.terr-sa.id
  description        = "Key for Terraform provider auth"
  key_algorithm      = "RSA_4096"  # или другой алгоритм
}

output "service_account_key_id" {
  value = yandex_iam_service_account_key.sa_key.id
  sensitive = true
}

output "private_key" {
  value     = yandex_iam_service_account_key.sa_key.private_key
  sensitive = true
}
