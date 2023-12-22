# beyondmd-test
# README

## Usage Instructions

In order to use this file, you must execute the appropriate command for your system:

- For Windows systems, go to https://nodejs.org/ and https://docs.docker.com/docker-for-windows/install/ in order to install the required packages.
If you don't know whether or not you have the required installations just use:
```
./start/start.bat
```
and the file will check for you. This is a work in progress and might not tell you if the proper npm packages are installed

Also Ansible will not be able to install with this system because fcntl is not supported on windows systems so if you wish to run this on the ansible side, you will have to use WSL

- For Debian/Ubuntu systems, use:
```
source start/start.sh
```
If this doesn't work then you might be on a virtual environment or inside of a container. If this is the case then you may run into issues when attempting to install docker and virtualbox specifically.
If this is the case then use a linux operating system that is not inside a virtual environment
Once this is done, the code will check your system for the appropriate packages, libraries, and software. If they are not present, it will attempt to install them.

## Automated Ansible Containers

this is the sugar on top that I didn't add in time, but wanted to complete anyway.
Currently the project isn't finished, but it should allow you to simply spin up 3 docker containers that will have 1 running the ansible playbook on 2 target containers. 
When this project is completed I will change this readme to show it

- in order to run this project you still use the start systems that were created previously, You will simply have to use
```
docker compose -f ansible-docker-compose.yml up
---
