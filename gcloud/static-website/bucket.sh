#!/bin/bash

gcloud storage buckets create gs://rossbucket2 -l eu --no-public-access-prevention

gcloud storage cp ./gcloud/static-website/html/* gs://rossbucket2

gcloud storage buckets add-iam-policy-binding  gs://rossbucket2 --member=allUsers --role=roles/storage.objectViewer

gcloud storage buckets update gs://rossbucket2 --web-main-page-suffix=index.html --web-error-page=404.html

# PUB LINK
# https://storage.googleapis.com/rossbucket2/index.html
