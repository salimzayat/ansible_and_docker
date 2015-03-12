# Overview

A simple vagrant setup for spinning up a simple master and agent, installing ansible on the master. The master uses ansible to install Docker on the agent and run a simple 'Hello World' app in docker

# NOTE

I am not sure how to set up ssh so that we can run ansible (i.e. ssh) from the master directly to the agent.  I did it by hand, via a simple ssh-keygen.
