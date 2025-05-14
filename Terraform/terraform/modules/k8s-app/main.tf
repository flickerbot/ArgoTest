resource "kubernetes_deployment" "app" {
  count = var.create_resources ? 1 : 0
  
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = merge({
          app = var.app_name
        }, var.labels)
      }

      spec {
        container {
          image = var.image
          name  = var.app_name
          
          port {
            container_port = var.port
          }
          
          env {
            name  = "ENVIRONMENT"
            value = var.environment
          }
          
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  count = var.create_resources ? 1 : 0
  
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels    = var.labels
  }
  
  spec {
    selector = {
      app = var.app_name
    }
    
    port {
      port        = var.port
      target_port = var.port
    }
    
    type = "ClusterIP"
  }
}