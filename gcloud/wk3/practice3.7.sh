#!/bin/bash

### ASSIGNMENT ###
# 3.7 VM Instances

###################
serviceName="chat-service"
vmName="chat-vm"
zone="europe-west1-b"
tags="chat"

# If the parameter ‘-d’ or ‘--delete’ is provided at the command line, remove the VM(s) and the firewall rule (script name: pract7.sh). The firewall rule should only be deleted when you delete the last instance making use of that tag.
if [[ $1 == "-d" ]];then
    gcloud compute instances delete $vmName --zone=$zone
    gcloud compute firewall-rules delete $serviceName
else
    # Create a firewall rule for TCP port 3000 + Add the target tag ‘chat’
    # gcloud compute firewall-rules list
    gcloud compute firewall-rules create $serviceName \
        --allow=tcp:3000 \
        --target-tags=$tags
    
    # Create a VM instance in zone ‘europe-west1-b’ with 1 CPU, approximately 4 GB of RAM, Ubuntu 22.04
    # Use an inline startup script to install the “Rocket Chat” server. Use ‘snaps’ for the installation. (If you don’t know what a ‘snap’ is, look it up).
    # gcloud compute images list
    gcloud compute instances create $vmName \
        --zone=$zone \
        --image=ubuntu-2204-jammy-v20240319 \
        --image-project=ubuntu-os-cloud \
        --custom-cpu=1 \
        --custom-memory=4 \
        --tags=$tags \
        --metadata=startup-script='#!/bin/bash
apt update
snap install rocketchat-server'
fi

