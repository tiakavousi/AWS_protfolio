#!/bin/bash

# Updating and installing NGINX:
apt-get update -y
apt-get install -y nginx

#Instance Metadata Retrieval:
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
SUBNET_ID=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/mac)/subnet-id)

# HTML File Generation:
cat <<EOL > /var/www/html/index.nginx-debian.html
<html>
    <head>
        <title>Instance Details</title>
    </head>
    <body>
        <h1>Welcome to my AWS Portfolio!</h1>
        <img src="https://${cloudfront_dns}/geek.jpeg" alt="Image" />
        <ul>
            <li>Instance ID: $INSTANCE_ID</li>
            <li>Instance Private IP: $PRIVATE_IP</li>
            <li>Subnet ID: $SUBNET_ID</li>
            <li>Image DNS: https://${cloudfront_dns}/geek.jpeg</li>
        </ul>
    </body>
</html>
EOL
