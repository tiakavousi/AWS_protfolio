#!/bin/bash
apt-get update -y
apt-get install -y nginx

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
SUBNET_ID=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/mac)/subnet-id)

cat <<EOL > /var/www/html/index.nginx-debian.html
<html>
    <head>
        <title>Instance Details</title>
    </head>
    <body>
        <h1>Welcome to my site!</h1>
        <ul>
            <li>Instance ID: $INSTANCE_ID</li>
            <li>Instance Private IP: $PRIVATE_IP</li>
            <li>Subnet ID: $SUBNET_ID</li>
            <li>Image DNS: https://${cloudfront_dns}/geek.jpeg</li>
        </ul>
        <img src="https://${cloudfront_dns}/geek.jpeg" alt="My Image">
    </body>
</html>
EOL
