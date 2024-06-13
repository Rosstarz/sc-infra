# resource "kubernetes_ingress_v1" "ingress" {
#   wait_for_load_balancer = true
#   metadata {
#     name = "ingress"
#   }

#   spec {
#     # default_backend {
#     #   service {
#     #     name = kubernetes_service.frontend-lb.metadata.0.name
#     #     port {
#     #       number = 80
#     #     }
#     #   }
#     # }

#     rule {
#       http {
#         path {
#           path = "/*"
#           backend {
#             service {
#               name = kubernetes_service.frontend-np.metadata.0.name
#               port {
#                 number = 80
#               }
#             }
#           }

#         }
#       }
#     }

#     tls {
#       secret_name = tls_self_signed_cert.certificate.metadata.0.name
#     }
#   }
# }

