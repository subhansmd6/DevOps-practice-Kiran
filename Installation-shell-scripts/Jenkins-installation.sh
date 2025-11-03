#!/bin/bash
#Jenkins installation script:

# Exit on error
set -e

# Step 1: Update system packages
echo "Updating system packages"
sudo apt update -y
sudo apt upgrade -y

# Step 2: Install Java (Jenkins requires Java 17+)
echo "Installing Java"
sudo apt install fontconfig openjdk-17-jre -y

# Verify Java installation
echo "Java version installed:"
java -version

# Step 3: Add Jenkins repository key and source list
echo "Adding Jenkins repository and installing Jenkins"
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install jenkins -y

# Step 4: Enable and start Jenkins service
echo "Enabling and starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Step 5: Allow Jenkins port (8080) through firewall
echo "Configuring firewall"
sudo ufw allow 8080
sudo ufw reload

# Step 6: Display initial admin password
echo "Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Login using the above password to complete setup."
echo "==========================================="
