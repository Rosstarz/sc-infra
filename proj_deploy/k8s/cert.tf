# resource "tls_private_key" "key" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# resource "tls_self_signed_cert" "certificate" {
#   private_key_pem = tls_private_key.key.private_key_pem

#   # Certificate expires after 12 hours.
#   validity_period_hours = 1

#   # Generate a new certificate if Terraform is run within three
#   # hours of the certificate's expiration time.
#   #   early_renewal_hours = 3

#   # Reasonable set of uses for a server SSL certificate.
#   allowed_uses = [
#     "key_encipherment",
#     "digital_signature",
#     "server_auth",
#   ]

#   #   dns_names = ["example.com", "example.net"]

#   subject {
#     common_name  = "example.com"
#     organization = "ACME Examples, Inc"
#   }
# }

# resource "kubernetes_secret" "certificate" {
#   metadata {
#     name = "certificate"
#   }

#   data = {
#     username = "admin"
#     password = "P4ssw0rd"
#   }

#   type = "kubernetes.io/basic-auth"
# }
