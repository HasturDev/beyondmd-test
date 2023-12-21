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
    sudo apt install virtualbox virtualbox-qt virtualbox-dkms
    sudo apt install virtualbox-ext-pack
    sudo dpkg-reconfigure virtualbox-dkms
    sudo dpkg-reconfigure virtualbox
    echo "if this does not work then please try installing the linux-headers-generic or going to this page for further information https://stackoverflow.com/questions/60350358/how-do-i-resolve-the-character-device-dev-vboxdrv-does-not-exist-error-in-ubu"
    echo "if this does not work then please try going to https://askubuntu.com/questions/1297786/virtualbox-20-10-new-error-warning-the-character-device-dev-vboxdrv-does-not"
    echo "if that still doesn't work then you are missing important linux headers and will need to install the necessary ones"
else
    echo "Virtualbox is installed."
fi

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
     # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
}

# Function to install Node.js
install_nodejs() {
    sudo apt install nodejs npm
}

