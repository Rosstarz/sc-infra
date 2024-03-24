#!/bin/bash

# Create a firewall rule for TCP port 3000
gcloud compute firewall-rules create chat-service --allow=tcp:3000 --target-tag=chat

gcloud compute instances create chat-vm --zone=europe-west1-b --custom-cpu=1 --custom-memory=4 --image=projects/ubuntu-os-pro-cloud/global/images/ubuntu-pro-2204-jammy-v20220923 --tags=chat --metadata startup-script-url=https://raw.githubusercontent.com/Rosstarz/sc-infra/main/startup.sh
