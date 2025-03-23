#!/bin/bash

#update system 
sudo add-apt-repository universe
sudo apt-get update -y


#install java
sudo apt-get install ca-certificates curl wget gnupg openjdk-17-jre -y

sudo install -m 0755 -d /etc/apt/keyrings

#check and add jenkins to repo list
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /etc/apt/keyrings/trivy.gpg > /dev/null

sudo echo "deb [signed-by=/etc/apt/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list


sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt-get install jenkins docker-ce docker-ce-cli containerd.io docker-buildx-plugin trivy -y

sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins

#restart docker for group permission affects to kick in
newgrp docker

sudo chmod 777 /var/run/docker.sock

#make sure docker run on start of machine
sudo systemctl restart docker 
sudo systemctl enable jenkins
sudo systemctl enable --now docker