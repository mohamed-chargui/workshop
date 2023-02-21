#Installing the Default JRE/JDK
#update the cache
sudo apt update ,-y 
sudo apt install default-jre -y
sudo apt install default-jdk -y

#install jenkins 
#First, add the repository key to the system
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

#append the Debian package repository address to the server’s sources.list
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install jenkins -y

#start and enable jenkins 
sudo systemctl start jenkins 
sudo systemctl enable jenkins
sudo systemctl status jenkins 

#in case the firewall is closed 
sudo ufw allow 8080
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status

#install ansible 
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y

#install docker 
sudo apt-get update -y
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
#Add Docker’s official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#Install Docker Engine
sudo apt-get update -y
#Receiving a GPG error when running apt-get update
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
#sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#start and enable docker 
sudo systemctl start docker 
sudo systemctl enable docker

#install minikube 
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl wget apt-transport-https
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod +x /usr/local/bin/minikube

#install kubectl utility
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

#add user to docker group 
sudo usermod -aG docker $USER && newgrp docker

#start minikube 
minikube start --driver=docker

