# App Deployment Project

## About


## CloudSQL
`db.tf`

Managed Postgres database for use by the backend application.

## GKE

## Container Registry
Using Gitlab's container registry within this project's Gitlab for images of backend and frontend applications.

[Provision a GKE cluster using Terraform](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider?variants=kubernetes%3Agke)

Retrieve access credentials for cluster and configure kubectl
```
gcloud container clusters get-credentials infra3-gke --region europe-west1-b
```
