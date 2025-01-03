#! /bin/bash

# aw.thepensivemind.com
# By Jorge Arrieta
# Version 0.01

# Update the package index
sudo apt update

# Installing, starting, and enabling Nginx
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Installing certbot to enble https in Nginx
sudo apt install -y certbot python3-certbot-nginx

# Run Certbot with Nginx to obtain and install SSL cert
sudo certbot --nginx -d aw.thepensivemind.com --non-interactive --agree-tos --email dprovenger@yahoo.com

# Reload Nginx
sudo systemctl reload nginx

# Installing index.html file
echo "${file("index.html")}" > /var/www/html/index.html

# Installing networking utilities
sudo apt -y install net-tools 