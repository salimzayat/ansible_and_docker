#!/bin/sh
# install ansible
sudo apt-get install software-properties-common -yq
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -yq
sudo apt-get install ansible -yq

# Configure /etc/hosts file
echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.32.5    master.example.com  master" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.32.10   agent.example.com agent" | sudo tee --append /etc/hosts 2> /dev/null && \

echo "[local]" > /etc/ansible/hosts
echo "192.168.32.10" >> /etc/ansible/hosts

# configure a simple one-off ansible playbook to bootstrap docker
/usr/bin/ansible-playbook -s install_docker.yaml
# and a test
/usr/bin/ansible-playbook -s test_docker.yaml