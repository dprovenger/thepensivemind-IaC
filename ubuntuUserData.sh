#! /bin/bash

# aw.thepensivemind.com
# By Jorge Arrieta
# Version 0.01

# Update the package index
sudo apt update

# Installing, starting, and enabling nginx
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Installing networking utilities
sudo apt -y install net-tools 