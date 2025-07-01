
# Вывод информации о созданном сервисном аккаунте
output "service_account_id" {
  description = "ID"
  value       = yandex_iam_service_account.terr-sa.id
}

output "service_account_name" {
  description = "Name of the created service account"
  value       = yandex_iam_service_account.terr-sa.name
}
