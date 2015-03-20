# Overview

A simple vagrant setup for spinning up a simple master and agent, installing ansible on the master. The master uses ansible to install Docker on the agent and run a simple 'Hello World' app in docker

## To run

```
$ vagrant up
$ vagrant ssh master
[vagrant@master ~]$ sudo su root
[root@master vagrant]# ansible-playbook -s /vagrant/ansible/install_docker.yaml
# at this point, you will have to accept the agent's IP into your known_hosts
[root@master vagrant]# ansible-playbook -s /vagrant/ansible/test_docker.yaml 
```

I tried to set it up so that you can automatically set up the known_hosts on the master, but whatever.  It works.

## Notes

* This runs on CentOS v6.5, which involves a bit more hassle when installing ansible and docker.  See steps here (https://docs.docker.com/installation/centos/#installing-docker-centos-65) and here (http://docs.ansible.com/intro_installation.html#latest-release-via-yum).
* You will have find a vagrant_rsa and vagrant_rsa.pub files created in your ./tmp directory.  Ignore them. I added the appropriate hooks in .gitignore, but still, be aware they will be there
