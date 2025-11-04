#!/bin/bash

set -e

echo "Installing and Starting Nexus 3"

# Update system and install Java + wget + unzip
sudo apt update -y
sudo apt install -y openjdk-17-jre-headless wget tar -y

# Download specific Nexus version (replace with latest stable if needed)
wget https://download.sonatype.com/nexus/3/nexus-3.85.0-03-linux-x86_64.tar.gz

# Extract Nexus
tar -xvzf nexus-3.85.0-03-linux-x86_64.tar.gz

# Rename extracted folder to nexus
mv nexus-3.85.0-03 nexus

# Change to Nexus bin directory
cd nexus/bin

# Start Nexus in background
./nexus start

# Wait a few seconds
sleep 5

# Check status
./nexus status || true

#Initial password
sudo cat /home/ubuntu/sonatype-work/nexus3/admin.password

echo " This is initial password of Nexus"
echo " ✅ Nexus started successfully!"
echo "Access it in your browser: http://$(hostname -I | awk '{print $1}'):8081"
