# Volumes and Networking
### Overview
The purpose of this assignment is to mount a local Docker Volume to a container at runtime, and use this mounted volume as the root directory for the webserver running in the container. The webpage must be published on a newly created network, on a non-standard port.

### Requirements / Steps
Create a Docker Volume called static-html. Search this folder on your local system.
Once you’ve found this folder, create in the _data subfolder a simple index.html file.

```
docker volume create static-html
docker volume list
echo "hi" > /var/lib/docker/volumes/static-html/_data/index.html
```

Create a new network assign99, driver bridge with following settings:
gateway: 172.20.0.1
subnet range: 172.20.0.0/24

```
docker network create -d bridge --gateway=172.20.0.1 --subnet=172.20.0.0/24 assign99
```

In LAB 8.2 you created a Dockerfile with an nginx Entrypoint. Use this same Dockerfile, but remove the line where you create the index.html file. We are not going to host the webpage directly from the container, but rather the one in the static-html folder, which we are going to mount to /var/www/html at runtime.

```
FROM almalinux:9
RUN dnf install -y httpd
ENTRYPOINT [ "/usr/sbin/httpd", "-D", "FOREGROUND"]
```

Build and run a detached container based on this image; publish the page on port 8000 of localhost, making use of the network assign99. Make sure the correct folder is mounted to the container.

```
docker build -t infra:wk9 .
docker run -d --network=assign99 -p 8000:80 -v static-html:/var/www/html infra:wk9
```

Check that the page is available in a web browser, on the appropriate port.
```
curl localhost:8000
```

Extra:
While the webpage is displayed, change the contents of the index.html page. Refresh the webpage in the browser, verify that the displayed page changes in the browser as well.

**DONE**

While the container is running, inspect the container. Take note of the IP address and the name of the container.

```
docker inspect musing_hermann
```
```
[
    {
        "Id": "fc0f819619a371e53c3968d3b9e26cef2118e0dc713509afabe79ea29fa42a33",
        "Created": "2024-05-04T21:26:16.791837805Z",
        "Path": "/usr/sbin/httpd",
        "Args": [
            "-D",
            "FOREGROUND"
        ],
        "Name": "/musing_hermann",
        ...
        "NetworkSettings": {
            ...
            "Networks": {
                "assign99": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "MacAddress": "02:42:ac:14:00:02",
                    "NetworkID": "05647cd2d8b441346d81a3a553bb97b6ff40946bb756de8f541f55d361905ea4",
                    "EndpointID": "35b69dd450ae23d9fc16c924ab824a56c07c5558035e3d5a8b0a4ec048fa05f8",
                    "Gateway": "172.20.0.1",
                    "IPAddress": "172.20.0.2",
                    "IPPrefixLen": 24,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "DriverOpts": null,
                    "DNSNames": [
                        "musing_hermann",
                        "fc0f819619a3"
                    ]
                }
            }
        }
    }
]

```

Start an additional interactive container (eg. based on almalinux:9) on network assign99 with access to the terminal. Verify that you can ping the webserver container by name.

```
docker run -it --network=assign99 google/cloud-sdk:alpine /bin/sh
ping google.com
ping musing_hermann
curl musing_hermann
```
