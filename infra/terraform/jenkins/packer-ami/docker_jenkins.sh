#! /bin/bash

#get in root 
whoami
#update to get docker repo
sudo apt update 

#install docker
sudo apt install docker.io -y

#adding ubuntu to docker group
sudo usermod -aG docker ubuntu

#restart docker for group permission affects to kick in
newgrp docker
#make sure docker run on start of machine
sudo systemctl restart docker 
sudo systemctl enable --now docker

mkdir jenkins_home
#run container
sudo docker run \
    --detach \
    --restart on-failure \
    -u $(id -u):$(id -g) \
    -v ~/jenkins_home:/var/jenkins_home \
    -p 8080:8080 -p 50000:50000 \
    --name jenkins_controller \
    jenkins/jenkins:lts-jdk11

sudo chown ubuntu:ubuntu jenkins_home

