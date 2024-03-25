#!/bin/bash

### ASSIGNMENT ###
# 5.11 Generate personal certificate

# Create a keypair and personal certificate using “openssl”.
# Whereby of the certificate contains your name (CN, common name) and mail address (emailaddress). Other fields such as country, state, organization etc. can be freely chosen.

# Required:
# Use the command “openssl req”.
# Keys and certificates must be in PEM format.

###################

openssl genrsa -out privkey.pem 4092
openssl rsa -in privkey.pem -pubout -out pubkey.pem
openssl req \
    -outform PEM -nodes \
    -key privkey.pem \
    -x509 -days 365 -out cert.pem \
    -subj "/C=US/ST=New York/L=Brooklyn/O=Brooklyn Company/CN=Rostislav Rucka/emailAddress=rostislav.rucka@student.kdg.be"

# openssl x509 -inform DER -outform PEM -in cert.crt -out cert.crt.pem
# openssl rsa -inform DER -outform PEM -in privkey.key -out privkey.key.pem
