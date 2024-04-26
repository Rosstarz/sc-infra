<!-- First Images and Containers
Create your own image & commit
In this assignment you will create your own customised apache web server image…
Write the commands/code in the blank fields.
Note: In an upcoming class we’ll see how to run the web server and how to access the web pages.

Start an interactive container based on Alma Linux. -->

# Command to create an interactive container:
docker run --interactive --tty --name infra-wk7 almalinux:latest




<!-- Install the apache2 ( httpd) web server in the container -->

# Command to install a web server:
dnf update
dnf install httpd
httpd -v


<!-- Add a simple web page to the default location. -->

# Command: 
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>

<h1>My First Heading</h1>
<p>My first paragraph.</p>

</body>
</html>
EOF

chmod 644 /var/www/html/index.html
ls -al /var/www/html/
apachectl configtest




<!-- Exit the container. Commit the stopped container to a new image on repository myacs, with name myfirstimage and tag acs.
add an author name and an email address to the commit
add an appropriate commit message -->

# Full commit command:
docker container commit \
    --author "Ross Rucka <rostislav.rucka@student.kdg.be>" \
    --message "Almalinux base with httpd and simple website" \
    infra-wk7 myacs/myfirstimage:acs




<!-- Verify that the new image is available locally. -->

# Verify command:
docker images myacs/myfirstimage
docker image ls | grep acs




<!-- Check the image with the ‘inspect’ command -->

# Inspect command:
docker image inspect myacs/myfirstimage:acs




<!-- Verify by running an interactive container from the new image.
→ check if the web server application has been installed (with which or command -v).  -->

# Run the image:
docker run -it --name infra-wk7-1 myacs/myfirstimage:acs
command -v httpd
httpd -v



<!-- Extra -->

# Push to docker hub:
docker tag myacs/myfirstimage:acs rosstarz/myacs:latest
docker login
docker push rosstarz/myacs:latest
