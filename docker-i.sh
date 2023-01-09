#!/bin/bash

apt-get remove docker docker-engine docker.io containerd runc
# uninstall all docker version
apt-get update
apt-get install ca-certificates curl gnupg lsb-release
# updating packages
mkdir -p /etc/apt/keyrings
# create directory keyrings
[ ! -f /etc/apt/keyrings/docker.gpg ] && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || echo "Already docker image"
#get docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#set docker repository
VERSION_STRING=5:20.10.13~3-0~ubuntu-jammy
# set a version to get a common version
apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-compose-plugin
#install docker specific version
[ docker ] && echo "Docker installation successed " || "Docker installation failed"
#run docker test
