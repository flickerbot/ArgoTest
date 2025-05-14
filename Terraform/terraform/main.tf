provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Create namespace for our applications
resource "kubernetes_namespace" "apps" {
  metadata {
    name = "demo-apps"
  }
}

# Deploy App1 with Terraform
module "app1" {
  source = "./modules/k8s-app"
  
  create_resources = var.app1_managed_by_terraform
  app_name         = "app1"
  namespace        = kubernetes_namespace.apps.metadata[0].name
  image            = "nginx:1.19"
  replicas         = var.app1_replicas
  port             = 80
  environment      = "dev"
  labels           = {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/name"       = "app1"
  }
}

# Deploy App2 with Terraform
module "app2" {
  source = "./modules/k8s-app"
  
  create_resources = true
  app_name         = "app2"
  namespace        = kubernetes_namespace.apps.metadata[0].name
  image            = "nginx:1.20"
  replicas         = 1
  port             = 80
  environment      = "dev"
  labels           = {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/name"       = "app2"
  }
}

# Output the URLs
output "app1_service_name" {
  value = module.app1.service_name
}

output "app2_service_name" {
  value = module.app2.service_name
}