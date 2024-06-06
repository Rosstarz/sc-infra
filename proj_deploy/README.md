# App Deployment Project

[[TOC]]

## About
- Class: ACS202
- Course: Infrastructure 3
- Name: Rostislav Rucka

This project includes IaC and configuration files for deploying a backend and frontend application on Google Cloud Kubernetes Engine together with a persistent database.

## VPC network
`gcloud/network.tf`

Network with 1 subnet. Used for private communication between GKE and Cloud SQL. And allowing access to GKE load balancer from internet.

## Cloud SQL
`gcloud/db.tf`

Managed Postgres database for use by the backend application on GKE. Public access disabled. Internal private IP assigned for use by backend application.

## GKE
`gcloud/gke.tf`

Kubernetes cluster with a worker node pool. Number of worker nodes with machine configuration speicifed.

## Kubernetes on GKE cluster
`k8s/`

Retrieve access credentials for cluster and configure kubectl
```
gcloud container clusters get-credentials infra3-gke --region europe-west1-b
```

### Backend


## Private Container Registry
Using Gitlab's private container registries of backend and frontend applications projects.

### Create Secret for Kubernetes 
(not ideal for production as secrets stored unencrypted in the k8s API server's underlying data store)
```
kubectl create secret docker-registry $secret_name \
--docker-server=<DOCKER_REGISTRY_SERVER> \
--docker-username=<DOCKER_USER> \
--docker-password=<DOCKER_PASSWORD> \
--docker-email=<DOCKER_EMAIL> -o yaml > docker-secret.yaml
```
`kubectl create -f docker-secret.yaml`

## Resources

[Provision a GKE cluster using Terraform](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider?variants=kubernetes%3Agke)