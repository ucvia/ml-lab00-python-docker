cat ../ucv.txt

echo '\n\n---- Installing docker and docker-compose ----'

USERNAME=${1:-ubuntu}

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USERNAME
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose     

sudo curl -O https://desktop.docker.com/linux/main/amd64/docker-desktop-4.25.0-amd64.deb
sudo apt-get -y install ./docker-desktop-4.25.0-amd64.deb 
systemctl --user start docker-desktop
