# Use the official Rocky Linux 9 base image
FROM rockylinux:9

# Update the system and install required packages
RUN yum -y update && \
    yum -y install wget apr apr-* gcc pcre-devel redhat-rpm-config

# Download Apache HTTP Server source code
WORKDIR /tmp
RUN wget https://downloads.apache.org/httpd/httpd-2.4.57.tar.gz && \
    tar -xvzf httpd-2.4.57.tar.gz

# Build and install Apache HTTP Server
WORKDIR /tmp/httpd-2.4.57
RUN ./configure --prefix=/3dx_app/dassault/reverse-proxy && \
    make clean && \
    make && \
    make install

# Clean up temporary files
WORKDIR /
RUN rm -rf /tmp/httpd-2.4.57 /tmp/httpd-2.4.57.tar.gz
# Expose port 80
EXPOSE 80

# Change working directory to the Apache installation path
WORKDIR /3dx_app/dassault/reverse-proxy/bin

# Start Apache HTTP Server
#CMD ["./apachectl", "-k", "start"]
