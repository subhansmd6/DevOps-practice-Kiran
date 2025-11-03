#!/bin/bash

set -e

echo " 🚀 Installing and Starting SonarQube 10.6.0.92116"

# Update and install Java + unzip + wget
sudo apt update -y
sudo apt install -y openjdk-17-jre-headless unzip wget -y

# Download SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.6.0.92116.zip

# Extract the archive
unzip sonarqube-10.6.0.92116.zip

# Rename extracted directory
mv sonarqube-10.6.0.92116 sonarqube

# Go to SonarQube binary folder
cd sonarqube/bin/linux-x86-64

# Start SonarQube
./sonar.sh start

# Check status
./sonar.sh status || true

echo " ✅ SonarQube started successfully!"
