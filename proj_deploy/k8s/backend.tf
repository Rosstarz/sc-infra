resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend-app"
    labels = {
      App = "prog5"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "prog5"
      }
    }
    template {
      metadata {
        labels = {
          App = "prog5"
        }
      }
      spec {
        image_pull_secrets {
          name = "gitlab-registry"
        }
        container {
          image = "registry.gitlab.com/kdg-ti/programming-5/projects-23-24/acs202/rostislav.rucka/programming-5"
          name  = "prog5-app"

          port {
            container_port = 80
          }

          env {
            name  = "DB_ADDRESS"
            value = data.google_sql_database_instance.main.private_ip_address
          }

          env {
            name  = "DB_NAME"
            value = var.postgres_db
          }

          env {
            name  = "DB_PORT"
            value = var.postgres_port
          }

          env {
            name  = "DB_USERNAME"
            value = var.postgres_user
          }

          env {
            name  = "DB_PASSWORD"
            value = var.postgres_password
          }

          env {
            name  = "TEMP"
            value = var.postgres_password
          }

          # resources {
          #   limits = {
          #     cpu    = "0.5"
          #     memory = "512Mi"
          #   }
          #   requests = {
          #     cpu    = "250m"
          #     memory = "50Mi"
          #   }
          # }
        }
      }
    }
  }
}

// Persistent IP address for the backend service
resource "kubernetes_service" "backend-svc" {
  metadata {
    name = "backend-svc"
  }
  spec {
    selector = {
      App = kubernetes_deployment.backend.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}

// Loadbalancer only because the backend app contains some frontend as well
resource "kubernetes_service" "backend-lb" {
  metadata {
    name = "backend-lb"
  }
  spec {
    selector = {
      App = kubernetes_deployment.backend.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

output "backend-lb-ip" {
  value = kubernetes_service.backend-lb.status.0.load_balancer.0.ingress.0.ip
}

output "backend-svc-ip" {
  value = kubernetes_service.backend-svc.spec.0.cluster_ip
}