#!/bin/bash

#update system 
sudo apt-get update -y 

#install java
sudo apt-get install openjdk-21-jdk -y

#check and add jenkins to repo list
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

#update system to pull repo 
sudo apt-get update -y 

#install jenkins using apt package management
sudo apt-get install jenkins -y


#enable jenkins to start when system starts
sudo systemctl enable jenkins





