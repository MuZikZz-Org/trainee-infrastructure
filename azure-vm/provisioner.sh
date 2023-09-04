#!/usr/bin/env bash

# Install dependencies (e.g., Java)
sudo apt-get update
echo "update done"

sudo apt-get install -y openjdk-11-jdk
echo "install openjdk done"

# Download and install SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.0.1.46107.zip
echo "get sonarqube done"

sudo apt-get install -y unzip
echo "install unzip done"

unzip sonarqube-9.0.1.46107.zip
echo "unzip done"

mv sonarqube-9.0.1.46107 /opt/sonarqube
echo "mv done"

# Configure SonarQube settings (e.g., database connection)
# ...

# Start SonarQube
#/opt/sonarqube/bin/linux-x86-64/sonar.sh start

# Run SonarScanner or other code scanning commands
# Make sure to configure SonarScanner to connect to your SonarQube instance
# Example: sonar-scanner -Dsonar.projectKey=my-project-key -Dsonar.sources=.

