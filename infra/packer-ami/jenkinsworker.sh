#! /bin/bash

#update system 
sudo add-apt-repository universe
sudo apt update 

sudo apt-get install ca-certificates curl openjdk-17-jre -y

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y

sudo usermod -aG docker ubuntu

#restart docker for group permission affects to kick in
newgrp docker

sudo chmod 777 /var/run/docker.sock

#make sure docker run on start of machine
sudo systemctl restart docker 
sudo systemctl enable --now docker

