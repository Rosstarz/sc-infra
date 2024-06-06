# resource "kubernetes_secret" "gitlab-registry" {
#   metadata {
#     name = "gitlab-registry"
#   }

#   data = {
#     ".dockerconfigjson" = "${file("${var.gitlab_secret_file}")}"
#   }

#   type = "kubernetes.io/dockerconfigjson"
# }

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
          # name = kubernetes_secret.gitlab-registry.metadata.0.name
          name = "gitlab-registry"
        }
        container {
          image = "registry.gitlab.com/kdg-ti/programming-5/projects-23-24/acs202/rostislav.rucka/programming-5"
          name  = "prog5-app"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

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

output "lb_ip" {
  value = kubernetes_service.backend-lb.status.0.load_balancer.0.ingress.0.ip
}
