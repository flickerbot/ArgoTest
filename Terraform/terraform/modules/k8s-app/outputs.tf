output "deployment_name" {
  value = var.create_resources ? kubernetes_deployment.app[0].metadata[0].name : null
}

output "service_name" {
  value = var.create_resources ? kubernetes_service.app[0].metadata[0].name : null
}