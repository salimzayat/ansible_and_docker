#!/bin/sh

# we need to handle all the ssh configuration between agent and master
# to that end, make sure we have an ~/.ssh directory...
if [ ! -d ~/.ssh/ ]; then
	echo "creating a .ssh directory"
	sudo mkdir ~/.ssh
fi

# and an authorized_keys files
if [ ! -f ~/ssh/authorized_keys ]; then
	echo "creating authorized_keys"
	touch ~/.ssh/authorized_keys
fi

# if we have not yet added the master to the authorized keys, do so now by leveraging the vagrant_rsa public key that is in the shared directory
if grep -q "vagrant@master.example.com" ~/.ssh/authorized_keys; then
	echo "no need to add to authorized keys"
else
	echo "adding to authorized keys"
	cat /vagrant/vagrant_rsa.pub >> ~/.ssh/authorized_keys
fi

# time to install some software:
# cgroup
sudo yum install -y libcgroup
sudo sh /vagrant/cgroupfs-mount
# selinux
sudo yum install -y libselinux-python
