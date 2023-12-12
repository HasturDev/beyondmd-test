#!/bin/bash

# Check if the system is Debian or Ubuntu
if [[ -x "$(command -v lsb_release)" ]]; then
    distro=$(lsb_release -is)
    if [[ "$distro" != "Ubuntu" && "$distro" != "Debian" ]]; then
        echo "This script is meant for Debian/Ubuntu Systems. Please find a proper installation method for Docker and Node.js for your environment."
        exit 1
    fi
else
    echo "Cannot determine the distribution or lsb_release not found. This script is meant for Debian/Ubuntu Systems."
    exit 1
fi
# Check for Vagrant
if ! command -v vagrant &> /dev/null
then
    echo "Vagrant is not installed."
    echo "Installing Vagrant..."
    sudo apt install vagrant
else
    echo "Vagrant is installed."
fi

# Check for Virtualbox
if ! command -v Virtualbox &> /dev/null
then
    echo "Virtualbox is not installed."
    echo "Installing Virtualbox..."
    sudo apt-get install virtualbox
else
    echo "Virtualbox is installed."
fi

# Function to install Vagrant
install_vagrant() {
    # Add your Vagrant installation steps here
}

# Function to install Virtualbox
install_virtualbox() {
    # Add your Virtualbox installation steps here
}
# Check for Docker
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed."
    echo "Installing Docker..."
    install_docker
else
    echo "Docker is installed."
fi

# Check for npm
if ! command -v npm &> /dev/null
then
    echo "npm is not installed."
    echo "Installing Node.js (which includes npm)..."
    install_nodejs
else
    echo "npm is installed."
fi

# Function to install Docker
install_docker() {
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker

    # Add Docker to PATH
    echo 'export PATH="/usr/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
}

# Function to install Node.js
install_nodejs() {
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs

    # Add npm to PATH
    echo 'export PATH="/usr/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
}

