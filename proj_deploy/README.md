# App Deployment Project

## About
- Class: ACS202
- Course: Infrastructure 3
- Name: Rostislav Rucka

This project includes IaC and configuration files for deploying a backend and frontend application on Google Cloud Kubernetes Engine together with a persistent database.

## VPC network
`gcloud/network.tf`

Network with a subnet. Used for private communication between GKE and Cloud SQL. And allowing access to GKE from internet.

## Cloud SQL
`gcloud/db.tf`

Managed Postgres database for use by the backend application on GKE. Public access disabled. Internal private IP assigned for use by backend application.

## GKE
`gcloud/gke.tf`

Kubernetes cluster with a worker node pool. Number of worker nodes with machine configuration speicified.

## Kubernetes on GKE cluster
`k8s/`

### Provider Configuration
`k8s/provider.tf`

Fetches GKE infrastructure on Google Cloud and sets up a connection to kubernetes on it.

Command to retrieve access credentials for cluster and configure kubectl
```
gcloud container clusters get-credentials infra3-gke --region europe-west1-b
```

### Backend Application
`k8s/backend.tf`

Kubernetes deployment of two replicas of backend application from Programming 5. Uses kubernetes secret to pull image from private repository. Passes environment variables to container for connection to Cloud SQL database.

A ClusterIP service is defined for communication with Frontend Application. A LoadBalancer service is defined because the Programming 5 project required some frontend parts to be inside backend application.

### Frontend Application
`k8s/frontend.tf`

Kubernetes deployment of two replicas of frontend application from Programming 5. Uses kubernetes secret to pull image from private repository. Passes environment variable for connection to backend application.

A LoadBalancer service is defined for access from internet.

### Ingress
`k8s/ingress.tf`

An ingress rule set routing all requests to frontend application. Can be used to redirect HTTP to HTTPS. Replaces LoadBalancer services.

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
```
kubectl create -f docker-secret.yaml
```

## Resources Used

- [Terraform Documentation](https://registry.terraform.io/)
- [Kubernetes Documentation](ttps://kubernetes.io/docs/)
- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Hashicorp Terraform Tutorials](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider?variants=kubernetes%3Agke)
