#### 1. Dockerfile

- Make a Dockerfile that uses almalinux v9 as a base image and that installs python3.
- Create locally a python hello world script.
- Use the Dockerfile to copy this file to the /opt folder. Make this folder the working directory.
- When you run the container, the python script needs to be executed, displaying a simple Hello World

Dockerfile
```
FROM almalinux:9

RUN dnf update -y \ 
    && dnf install python3 -y
WORKDIR /opt
COPY ./hello_world.py ./hello_world.py
CMD python3 ./hello_world.py
```
hello_world.py
```
print("Hello World!")
```

#### 2. Building, tagging and adding to local container registry

Tag this image (almalinux-python3:v1) and add it to your local registry.

```
docker build -t almalinux-python3:v1 -t localhost:5000/almalinux-python3:v1 .
docker push localhost:5000/almalinux-python3:v1
```

#### 3. Verify existence in local container registry

Check whether the image exists in your local container registry.

```
curl -i http://localhost:5000/v2/_catalog
curl -i http://localhost:5000/v2/almalinux-python3/tags/list
docker search almalinux-python3 (docker hub only)
```

#### 4. Remove the image from disk

Remove the image from disk. Leave the registry container running. Verify that the image does not exist any more locally by executing the command docker images.

```
docker image rm almalinux-python3:v1 localhost:5000/almalinux-python3:v1
docker images
```

#### 5. Verify existence in local container registry

Although you removed the image from the local disk, the image should still exist in your local registry container. Verify.

```
curl -i http://localhost:5000/v2/_catalog
curl -i http://localhost:5000/v2/almalinux-python3/tags/list
```

#### 6. Download image from local registry

Verify availability by downloading the image from the local registry

```
docker pull localhost:5000/almalinux-python3:v1
```

#### 7. Publish image to Docker Hub

Additionally, publish this container to your account on Docker Hub, in a public repository. Add the relevant information so that your teachers can verify the availability of this repository.


```
docker tag localhost:5000/almalinux-python3:v1 rosstarz/sc-almalinux-python3:v1
docker push rosstarz/sc-almalinux-python3:v1
```
- Accountname: rosstarz
- Repository: sc-almalinux-python3
- Link: https://hub.docker.com/r/rosstarz/sc-almalinux-python3
