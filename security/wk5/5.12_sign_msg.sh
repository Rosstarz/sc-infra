#!/bin/bash

### ASSIGNMENT ###
# 5.12 Sign message
# Sign a text message with your newly generated keypair.

# Your signed message will be in S/MIME format, signed mail. But is a format heavily used for secure information exchange over multiple protocols.

# S/MIME = secure MIME.
# MIME   = Multipurpose Internet Mail Extensions

# To avoid entering a during the signing process, pass the password as a shell variable:
# export STUDENT=<your password>
# openssl smime … -passin env:STUDENT

# Required:
# Use the “openssl smime” command to sign the message.
# Put your name and email within the message.
# The output must be a “MIME” message.
# Your message must be readable/visible in the signed message.

###################


# openssl pkeyutl \
#     -encrypt -inkey pubkey.pem \
#     -pubin -in top_secret.txt -out top_secret.enc

openssl smime \
    -sign \
    -keyform PEM \
    -in top_secret.txt -out mesg.signed -outform smime \
    -inkey privkey.pem -signer cert.pem
