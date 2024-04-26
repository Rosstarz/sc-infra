# Make a Dockerfile that uses almalinux v9 as a base image 
FROM almalinux:9

# and that installs python3.
RUN dnf update -y \ 
    && dnf install python3 -y
# Make /opt the working directory.
WORKDIR /opt
# Create locally a python hello world script.
# Use the Dockerfile to copy this file to the /opt folder. 
COPY ./hello_world.py ./hello_world.py
# When you run the container, the python script needs to be executed, displaying a simple Hello World.
CMD python3 ./hello_world.py
