FROM almalinux:9

RUN dnf install -y httpd
ENTRYPOINT [ "/usr/sbin/httpd", "-D", "FOREGROUND"]
