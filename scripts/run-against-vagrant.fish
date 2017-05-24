#!/usr/bin/env fish

ansible-playbook --private-key=~/.vagrant.d/insecure_private_key -uvagrant -i ./.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory $argv
