# Вывод ID созданного кластера
output "kubernetes_cluster_id" {
  description = "ID of the created Kubernetes cluster"
  value       = yandex_kubernetes_cluster.k8s_cluster.id
}
