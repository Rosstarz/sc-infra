resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend-app"
    labels = {
      App = "prog5-client"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "prog5-client"
      }
    }
    template {
      metadata {
        labels = {
          App = "prog5-client"
        }
      }
      spec {
        image_pull_secrets {
          name = "gitlab-registry"
        }
        container {
          image = "registry.gitlab.com/kdg-ti/programming-5/projects-23-24/acs202/rostislav.rucka/programming-5/client"
          name  = "prog5-client-app"

          port {
            container_port = 9000
          }

          env {
            name  = "PROG5_BACKEND_URL"
            value = "http://${kubernetes_service.backend-svc.metadata.0.name}"
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

resource "kubernetes_service" "frontend-lb" {
  metadata {
    name = "frontend-lb"
  }
  spec {
    selector = {
      App = kubernetes_deployment.frontend.spec.0.template.0.metadata[0].labels.App
    }

    port {
      port        = 82
      target_port = 9000
    }

    type = "LoadBalancer"
  }
}

output "frontend-lb-ip" {
  value = kubernetes_service.frontend-lb.status.0.load_balancer.0.ingress.0.ip
}

resource "kubernetes_service" "frontend-np" {
  metadata {
    name = "frontend-np"
  }
  spec {
    selector = {
      App = kubernetes_deployment.frontend.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 9000
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}