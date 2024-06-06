variable "project_root" {
  type    = string
  default = "../../"
}

variable "project_id" {
  type    = string
  default = "infra3-rucka-rostislav"
}

variable "project_name" {
  type    = string
  default = "infra3"
}

variable "gcp_sa_credentials" {
  type    = string
  default = "/.creds/infra3-rucka-rostislav-ae85433acb42.json"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "gke_username" {
  type    = string
  default = ""
}

variable "gke_password" {
  type    = string
  default = ""
}

variable "gke_num_nodes" {
  type        = number
  default     = 2
  description = "number of gke nodes"
}

variable "postgres_db" {
  type    = string
  default = "prog5"
}

variable "postgres_user" {
  type    = string
  default = "ross"
}

variable "postgres_password" {
  type    = string
  default = "postgres"
}

variable "gitlab_secret_file" {
  type    = string
  default = "~/.docker/config2.json"
}
