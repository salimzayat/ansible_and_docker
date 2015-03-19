#!/bin/sh
# install ansible
# we can do this in two ways:
# 1) via EPEL
# 2) via pip
##########
# EPEL
##########
# sudo rpm -Uvh --quiet http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

##########
# pip
##########
wget --no-check-certificate https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo easy_install pip
sudo yum install python-devel -yq
sudo yum install gcc -yq
sudo pip install ansible

sudo mkdir -p /etc/ansible

# Configure /etc/hosts file
echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.32.5    master.example.com  master" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.32.10   agent.example.com agent" | sudo tee --append /etc/hosts 2> /dev/null && \

echo "[local]" > /etc/ansible/hosts
echo "192.168.32.10" >> /etc/ansible/hosts

# we need to configure the ssh handshake between the master and agent(s)
# create the ~/.ssh directory
if [ ! -d ~/.ssh/ ]; then
	echo "creating a .ssh directory"
	sudo mkdir ~/.ssh
fi

if [ ! -f ~/.ssh/known_hosts ]; then
	echo "creating known hosts"
	touch ~/.ssh/known_hosts
fi

if [ ! -f /vagrant/tmp/vagrant_rsa ]; then
	echo "creating a new rsa cert"
	ssh-keygen -t rsa -C "vagrant@master.example.com" -N '' -f /vagrant/tmp/vagrant_rsa
fi

if [ ! -f ~/.ssh/vagrant_rsa ]; then
	echo "creating a new symlink to /vagrant/vagrant_rsa cert files"
	sudo ln -fs /vagrant/tmp/vagrant_rsa ~/.ssh/id_rsa
	sudo ln -fs /vagrant/tmp/vagrant_rsa.pub ~/.ssh/id_rsa.pub
fi

# # add it to ~/.ssh/known_hosts
# if grep -q "192.168.32.10" ~/.ssh/known_hosts; then
# 	echo "agent already added to known_hosts"
# else
# 	echo "adding agent to known_hosts"
# 	ssh-keyscan 192.168.32.10 | tee -a ~/.ssh/known_hosts
# 	cat ~/.ssh/known_hosts
# fi
