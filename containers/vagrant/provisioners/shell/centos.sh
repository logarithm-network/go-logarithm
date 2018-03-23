#!/bin/bash

sudo yum install -y git wget
sudo yum update -y

wget --continue https://storage.googleapis.com/golang/go1.8.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.8.1.linux-amd64.tar.gz

GHBC_PATH="~vagrant/go/src/github.com/logarithm-network/go-logarithm/build/bin/"

echo "export PATH=$PATH:/usr/local/go/bin:$GHBC_PATH" >> ~vagrant/.bashrc 
